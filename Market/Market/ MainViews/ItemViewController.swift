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
    override func viewDidLoad() {
        super.viewDidLoad()


    
    }
    
}
