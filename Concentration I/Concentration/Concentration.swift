//
//  Concentration.swift
//  Concentration
//
//  Created by Максим on 18.03.2021.
//

import Foundation

class  Concentration {
    var cards = [Card]()
    var score = 0
    var flipCount = 0 
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMathced {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMathced = true
                    cards[index].isMathced = true
                    scores(isMatched: true)
                } else {
                    cards[matchIndex].isTriggered = true
                    if cards[index].isTriggered {
                        scores(isMatched: false)
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flupDownIndex in cards.indices {
                    cards[flupDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func scores(isMatched: Bool) {
        if isMatched == true {
            score += 2
        } else {
            score -= 1
        }
    }
    
    func newGame() {
        flipCount = 0
        score = 0
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMathced = false
        }
        cards.shuffle()
        
    }
    
    init(numbersOfPairsOfCards: Int) {
        for _ in 1...numbersOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        cards.shuffle()
    }
    
    
}
