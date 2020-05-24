//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Glenn Cole on 5/24/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    //MARK: - Table Delegate methods
    
    @IBAction func addNewItem( _ sender: UIButton ) {
        
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex( of: newItem ) {
            
            let indexPath = IndexPath( row: index, section: 0 )
            tableView.insertRows( at: [indexPath], with: .automatic )
        }
    }
    
    @IBAction func toggleEditingMode( _ sender: UIButton ) {
        
        if isEditing {
            sender.setTitle( "Edit", for: .normal )
            setEditing( false, animated: true )
        }
        else {
            sender.setTitle( "Done", for: .normal )
            setEditing( true, animated: true )
        }
    }
}

//MARK: - Table Data Source methods

extension ItemsViewController {  // data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
        
        // set the text on the cell with the description of the item
        // that is the nth index of items, where n = row# this cell
        // will appear in the table view
        //
        let item = itemStore.allItems[ indexPath.row ]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
}