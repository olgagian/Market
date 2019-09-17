//
//  ItemViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 04/09/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit
import JGProgressHUD
class ItemViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    var item: Item!
    var itemImages: [UIImage] = []
    var hud = JGProgressHUD(style: .dark)
    private let sectionInSets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let cellHeight: CGFloat = 196.0
    private let itemsPerRow:CGFloat = 1
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        downloadPictures()
        
        self.navigationItem.leftBarButtonItems=[UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self , action:#selector(self.backAction))]
        self.navigationItem.rightBarButtonItems=[UIBarButtonItem(image: UIImage(named: "addToBasket"), style: .plain, target: self , action:#selector(self.addtoBasketButtonPressed))]
    }
    //MARK: - Download Pictures
    private func downloadPictures() {
        if item != nil && item.imageLinks != nil {
            downloadImages(imageUrls: item.imageLinks) { (allImages) in
                if allImages.count  > 0 {
                    self.itemImages = allImages as! [UIImage]
                    self.imageCollectionView.reloadData()
                    
                }
            }
        }
    }
    
    private func setupUI() {
        if item != nil {
            self.title = item.name
            nameLabel.text = item.name
            priceLabel.text = convertToCurrency(item.price)
            descriptionTextView.text = item.description
            
            
        }
        
    }
    //MARK- IBactions
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func  addtoBasketButtonPressed() {
        //TODO: check if uswe is logged in or show login view
        downloadBasketFromFirestore("1234") { (basket) in
            if basket == nil {
                self.createNewBasket()
            }else{
                basket!.itemIds.append(self.item.id)
                self.updateBasket(basket: basket!, withValues: [kITEMIDS : basket?.itemIds])
            }
        }
    }
    //MARK - Add to basket
    
    private func createNewBasket() {
        let newBasket = Basket()
        newBasket.id = UUID().uuidString
        newBasket.ownerId = "1234"
        newBasket.itemIds=[self.item.id]
        saveBasketToFirestore(newBasket)
        
        self.hud.textLabel.text = "Added to basket!"
        self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        self.hud.show(in: self.view)
        self.hud.dismiss(afterDelay: 2.0)
        
        
    }
    private func updateBasket(basket:Basket, withValues:[String:Any]) {
        updateBasketinFirestore(basket, withValues: withValues) { (error) in
            if error != nil {
                self.hud.textLabel.text = "Error:\(error!.localizedDescription)"
                    self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)
                print("error updating basket",error?.localizedDescription)
            }else {
                self.hud.textLabel.text = "Added to basket!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
        }
        
    }
}
extension ItemViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count == 0 ? 1: itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        if itemImages.count > 0 {
        cell.setupImageWith(itemImage: itemImages[indexPath.row])
        }
            return cell
    }
    
    
    
    
}
extension ItemViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - sectionInSets.left
        return CGSize(width: availableWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInSets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInSets.left
    }
}
