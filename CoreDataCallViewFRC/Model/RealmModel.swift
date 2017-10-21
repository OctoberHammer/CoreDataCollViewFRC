//
//  RealmModel.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/21/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//

import Foundation
import RealmSwift


class RmItem: Object, ItemCellViewModel {
    @objc dynamic var title = ""
    @objc dynamic var picture: Data?
    
    func getTitle()->String {
        return self.title 
    }
    func getPicture()->Data? {
        return self.picture
    }
}
