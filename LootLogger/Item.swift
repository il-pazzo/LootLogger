//
//  Item.swift
//  LootLogger
//
//  Created by Glenn Cole on 5/24/20.
//  Copyright © 2020 Glenn Cole. All rights reserved.
//

import UIKit

class Item: Codable {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    let itemKey: String
    
    init( name: String, serialNumber: String?, valueInDollars: Int ) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
    }
}

extension Item {
    
    convenience init( random: Bool = false ) {
        if !random {
            self.init( name: "", serialNumber: nil, valueInDollars: 0 )
            return
        }
        
        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let nouns = ["Bear", "Spork", "Mac"]
        
        let randomAdjective = adjectives.randomElement()!
        let randomNoun = nouns.randomElement()!
        
        let randomName = "\(randomAdjective) \(randomNoun)"
        let randomValue = Int.random(in: 0..<100)
        let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
        
        self.init( name: randomName,
                   serialNumber: randomSerialNumber,
                   valueInDollars: randomValue
        )
    }
}

extension Item: Equatable {
    
    static func ==( lhs: Item, rhs: Item ) -> Bool {
        
        return lhs.name == rhs.name
            && lhs.serialNumber == rhs.serialNumber
            && lhs.valueInDollars == rhs.valueInDollars
            && lhs.dateCreated == rhs.dateCreated
    }
}
