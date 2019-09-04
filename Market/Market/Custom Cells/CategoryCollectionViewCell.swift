//
//  CategoryCollectionViewCell.swift
//  Market
//
//  Created by ioannis giannakidis on 01/08/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    func  generateCell( _ category: Category){
        nameLabel.text = category.name
        ImageView.image = category.image
        
        
    }
}
