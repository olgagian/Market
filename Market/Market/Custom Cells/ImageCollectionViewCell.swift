//
//  ImageCollectionViewCell.swift
//  Market
//
//  Created by ioannis giannakidis on 04/09/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setupImageWith(itemImage: UIImage) {
        imageView.image = itemImage
        
    }
}
