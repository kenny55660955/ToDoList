//
//  Menu.swift
//  Todoey
//
//  Created by Kenny on 2021/6/14.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class Menu: Object {
    @objc var name: String = ""
    
    let items = List<Item>()
    
    
}
