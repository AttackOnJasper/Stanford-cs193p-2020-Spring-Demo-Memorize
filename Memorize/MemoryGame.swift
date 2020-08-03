//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jasper Wang on 2020-07-10.
//  Copyright © 2020 Jasper Wang. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { // Equatable is needed for comparison on properties
    private(set) var cards: Array<Card> // private(set) means setting is private, but reading is not private
    
    private var indexOfTheOnlyFaceUpCard: Int? {// auto init to nil
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
             }
        }
    }
    
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
        if let chosenIndex = self.cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched { // , == sequential AND
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    // namespace MemoryGame.Card
    // constrains & gains are used to make an object itentifiable
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // generic card game; does not care about the specific content on the card
        
        // implement Identifiable
        var id: Int
    }
}
