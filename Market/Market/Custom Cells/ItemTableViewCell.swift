//
//  ItemTableViewCell.swift
//  Market
//
//  Created by ioannis giannakidis on 04/09/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func generateCell(_ item: Item){
        
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.text = convertToCurrency(item.price)
        
        if item.imageLinks != nil && item.imageLinks.count > 0 {
            downloadImages(imageUrls: [item.imageLinks.first!]) { (images) in
                self.itemImageView.image = images.first as? UIImage
            }
        }
        
    }

}
