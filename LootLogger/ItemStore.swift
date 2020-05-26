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
    
    let itemArchiveURL: URL = {
        
        let documentDirectories = FileManager.default.urls(for: .documentDirectory,
                                                           in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent( "items.plist" )
    }()
    
    
    init() {
        loadSavedItems()
        
        // save when app goes to the background
        //
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver( self,
                                        selector: #selector(saveChanges),
                                        name: UIScene.didEnterBackgroundNotification,
                                        object: nil )
    }
    private func loadSavedItems() {
        
        do {
            let data = try Data( contentsOf: itemArchiveURL )
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode( [Item].self, from: data )
            allItems = items
        }
        catch {
            print( "Error reading previously-saved Items: \(error)" )
        }
    }
    
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
    
    @objc func saveChanges() -> Bool {
        
        print( "Saving Items to \(itemArchiveURL)" )
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode( allItems )
            try data.write( to: itemArchiveURL, options: [.atomic] )
            
            print( "Saved all Items!" )
            return true
        }
        catch let encodingError {
            print( "Error encoding allItems: \(encodingError)" )
            return false
        }
    }
}
