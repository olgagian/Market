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
    var hdu = JGProgressHUD(style: .dark)
    private let sectionInSets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let cellHeight: CGFloat = 196.0
    private let itemsPerRow:CGFloat = 1
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        downloadPictures()
        
        self.navigationItem.leftBarButtonItems=[UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self , action:#selector(self.backAction))]
        self.navigationItem.rightBarButtonItems=[UIBarButtonItem(image: UIImage(named: "basket"), style: .plain, target: self , action:#selector(self.addtoBasketButtonPressed))]
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
        print("Added to basket",item.name)
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
