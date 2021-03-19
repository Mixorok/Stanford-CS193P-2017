//
//  Card.swift
//  Concentration
//
//  Created by Максим on 18.03.2021.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMathced = false
    var identifier: Int
    var isTriggered = false
    
    static var identifierFactory = 0
    
    static func getUniqeIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqeIdentifier()
    }
}
