//
//  ItemCell.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/19/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//

import UIKit


protocol ItemCellViewModel {
    func getTitle()->String
    func getPicture()->Data?
}



class ItemCell: UICollectionViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with item: ItemCellViewModel) {
        self.titleLabel.text = item.getTitle()
        if let data = item.getPicture() {
            self.picture.image = UIImage(data: data)
        } else {
            self.picture.image = nil
        }
    }
}






