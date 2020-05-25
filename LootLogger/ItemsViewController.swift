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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear( animated )
        
        tableView.reloadData()
    }
    
    //MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let segueIdentifier = segue.identifier else {
            preconditionFailure( "Segue identifier not present" )
        }
        
        switch segueIdentifier {
        case "showItem":
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[ row ]
                let vc = segue.destination as! DetailViewController
                vc.item = item
            }
        default:
            preconditionFailure( "Unexpected segue identifier: \(segueIdentifier)" )
        }
    }
    
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

extension ItemsViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
        // set the text on the cell with the description of the item
        // that is the nth index of items, where n = row# this cell
        // will appear in the table view
        //
        let item = itemStore.allItems[ indexPath.row ]
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        cell.valueLabel.backgroundColor = item.valueInDollars < 50
            ? UIColor.systemGreen.withAlphaComponent( 0.20 )
            : UIColor.systemRed  .withAlphaComponent( 0.20 )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let item = itemStore.allItems[ indexPath.row ]
            itemStore.removeItem( item )
            tableView.deleteRows( at: [indexPath], with: .automatic )
        }
    }

    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        
        itemStore.moveItem( from: sourceIndexPath.row,
                            to: destinationIndexPath.row )
    }
}
