//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jasper Wang on 2020-07-10.
//  Copyright © 2020 Jasper Wang. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    // there can be multiple init methods with different arguments
    // ViewModel knows what cardContent to set, so we will pass a function to callback
    init(numberOfPairsOfCard: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCard {
            let cardContent = cardContentFactory(pairIndex) // does not need to explicitly set the type as Swift implies the value
            cards.append(Card(content: cardContent, id: pairIndex * 2))
            cards.append(Card(content: cardContent, id: pairIndex * 2 + 1))
        }
    }
    
    // every function which modifies self needs to have 'mutating' keyword
    mutating func choose(card: Card) {
        print("card chosen: \(card)") // swift is good at printing something in string
        let chosenIndex = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return -1 // TODO: fix return
    }
    
    // namespace MemoryGame.Card
    // constrains & gains are used to make an object itentifiable
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // generic card game; does not care about the specific content on the card
        
        // implement Identifiable
        var id: Int
    }
}
