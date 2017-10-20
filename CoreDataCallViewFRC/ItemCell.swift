//
//  ItemCell.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/19/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with item: Item) {
        if let title = item.title, let data = item.picture {
            self.titleLabel.text = title
            self.picture.image = UIImage(data: data)

        }
    }
    func configure(with item: InternalData) {
        if let title = item.title, let data = item.picture {
            self.titleLabel.text = title
            self.picture.image = UIImage(data: data)
            
        }
    }
}
