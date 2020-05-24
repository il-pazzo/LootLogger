//
//  ItemStore.swift
//  LootLogger
//
//  Created by Glenn Cole on 5/24/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        
        let newItem = Item( random: true )
        
        allItems.append( newItem )
        
        return newItem
    }
}
