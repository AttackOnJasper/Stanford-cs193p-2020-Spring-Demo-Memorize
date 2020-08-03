//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jasper Wang on 2020-07-10.
//  Copyright © 2020 Jasper Wang. All rights reserved.
//
// ViewModel in MVVM

import Foundation

// ViewModel is always a class. ViewModel never stores the View; instead, View always stores an instance of ViewModel
// For class type, the default initializer inits none of the vars
// ObservableObject: needed for Reactive UI
class EmojiMemoryGame: ObservableObject {
//    Explicit typing
//    private var memoryGame: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCard: 2, cardContentFactory: { (pairIndex: Int) -> String in
//        return ""
//    }) // function is inlined
    
//    // Implicit typing
//    private var memoryGame: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCard: 2, cardContentFactory: { pairIndex in ""})
     
//    // Let the last argument float outside
//    private var memoryGame: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCard: 2) { pairIndex in ""}
    
//    // If pairIndex is not used, use _ instead
//    private var memoryGame: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCard: 2) { _ in ""}
    
    @Published // a property wrapper; call objectWillChange upon the object changes
    private var memoryGame: MemoryGame<String> = createMemoryGame()
        
    // Add static keyword to properly initialize class property
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCard: 3) {index in
            return emojis[index]
        }
    }
    
    // MARK: - Access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        memoryGame.cards
    }
    
    // MARK: - Intent(s)
    
    func chooseCard(card: MemoryGame<String>.Card) {
        memoryGame.choose(card: card)
    }
}
