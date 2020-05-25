//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Glenn Cole on 5/25/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear( animated )
        
        let valueString = numberFormatter.string( from:
            NSNumber( value: item.valueInDollars )
        )
        let dateString = dateFormatter.string( from: item.dateCreated )
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = valueString
        dateLabel.text = dateString
    }
}
