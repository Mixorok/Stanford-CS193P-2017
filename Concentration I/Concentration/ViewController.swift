//
//  ViewController.swift
//  Concentration
//
//  Created by Максим on 18.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var indexTheme = 0 {
        didSet {
            print(indexTheme, keys[indexTheme])
            emojiChoices = theme[keys[indexTheme]] ?? []
            emoji = [Int: String]()
        }
    }
    
    var keys: [String] {return Array(theme.keys)}
    
    var theme = ["Hallowen": ["👻","🦇","😱","🎃", "😈", "🍎", "🍭", "🍬", "🙉", "🍁"],
                 "Animals": ["🐊","🐘","🦙","🐕", "🐇", "🦧", "🦏", "🐫", "🦓", "🦍"],
                 "Sports": ["⚽️","🏀","🏈","⚾️", "🥎", "🎾", "🏓", "🏄‍♀️", "🏆", "🥊"],
                 "Faces": ["😀","😊","😇","😏", "🥰", "😍", "🥺", "🥵", "😤", "🤗"],
                 "Cars": ["🚗","🚌","🚟","🚜", "🛵", "🏎", "🚑", "🚓", "🛴", "🛵"],
                 "Hearts": ["💛","💜","🤍","🤎", "💓", "💗", "💖", "🧡", "💙", "🖤"]
    ]
    
    override func viewDidLoad() {
        indexTheme = Int(arc4random_uniform(UInt32(keys.count)))
        flipCountLabel.text = "Flips: \(game.flipCount)"
        updateViewFromModel()
    }
    
    lazy var game = Concentration(numbersOfPairsOfCards:  (cardButtons.count + 1) / 2)

    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    //Button NewGame
    @IBAction func newGame(_ sender: UIButton) {
        indexTheme = Int(arc4random_uniform(UInt32(keys.count)))
        game.newGame()
        updateViewFromModel()
    }
    
    //Array of Buttons
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            
            updateViewFromModel()
        } else {
            print("Chosen card was ton in CardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMathced ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text =  "Flips: \(game.flipCount)"
    }
    
    
    
    
    lazy var emojiChoices = [""]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "nil"
    }
    
    
    
}

