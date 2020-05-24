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
    
    @discardableResult func createItem() -> Item {
        
        let newItem = Item( random: true )
        
        allItems.append( newItem )
        
        return newItem
    }
    
    func removeItem( _ item: Item ) {
        
        if let index = allItems.firstIndex( of: item ) {
            allItems.remove( at: index )
        }
    }
    
    func moveItem( from fromIndex: Int, to toIndex: Int ) {
        
        guard fromIndex != toIndex else {
            return
        }
        
        allItems.swapAt( fromIndex, toIndex )
    }
}
