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
}

//MARK: - Data Source methods

extension ItemsViewController {  // data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create an instance of UITableViewCell with default appearance
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
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
