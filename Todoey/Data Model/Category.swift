//
//  Category.swift
//  Todoey
//
//  Created by Martevol on 1/28/19.
//  Copyright © 2019 Martevol. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
