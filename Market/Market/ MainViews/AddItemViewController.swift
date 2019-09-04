//
//  AddItemViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 27/08/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView


class AddItemViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    //MARK: Vars
    var category: Category!
    var gallery: GalleryController!
    let hud = JGProgressHUD(style: .dark)
    
    var activityIndicator: NVActivityIndicatorView?
    var itemImages: [UIImage?] = []
    //MARK: View lifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballPulse, color: #colorLiteral(red: 0.9998469949, green: 0.4941213727, blue: 0.4734867811, alpha: 1.0), padding: nil)
    }

    //MARK:IBActions
    
    @IBAction func doneBarButtonItemPressed(_ sender: Any) {
        
        dismisskeyboard()
        if fieldsArecompleted() {
            saveToFirebase()
        } else {
            
            //TODO: Show error to the usee
            self.hud.textLabel.text = "All fields are required"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
        }
        
    }
    
    
    
    @IBAction func cameraButonPressed(_ sender: Any) {
        itemImages = []
        showImageGallery()
    }
    @IBAction func backgroundTapped(_ sender: Any) {
        dismisskeyboard()
        
    }
    // MARK: Helper Functions
    private func fieldsArecompleted() -> Bool{
        
        return(titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    
    private func dismisskeyboard() {
        self.view.endEditing(true)
        
    }
    private func popTheView() {
        self.navigationController?.popViewController(animated:true)
    }
    
    //MARK: Save Item
    private func saveToFirebase() {
        showLoadingIndicator()
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.categoryId = category.id
        item.description = descriptionTextView.text
        item.price = Double(priceTextField.text!)
        if itemImages.count > 0 {
            uploadImages(images: itemImages, itemId: item.id) { (imageLinkArray) in
                item.imageLinks = imageLinkArray
                saveItemToFireStore(item)
                self.hideLoadingIndicator()
                self.popTheView()
            }
        }else{
            saveItemToFireStore(item)
            popTheView()
            
        }
        
        
    }
    //MARK: Activity Indicator
    private func showLoadingIndicator() {
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    private func hideLoadingIndicator() {
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    //MARK: Shpw Gallery
    private func showImageGallery() {
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        self.present(self.gallery, animated: true, completion: nil)
        
    }
}

extension AddItemViewController: GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { (resolvedImages) in
                self.itemImages = resolvedImages
            }
            
        }
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
