//
//  Item.swift
//  Todoey
//
//  Created by Martevol on 1/28/19.
//  Copyright © 2019 Martevol. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}