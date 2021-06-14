//
//  Item.swift
//  Todoey
//
//  Created by Kenny on 2021/6/14.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    var parentCategory = LinkingObjects(fromType: Menu.self, property: "items")
}
