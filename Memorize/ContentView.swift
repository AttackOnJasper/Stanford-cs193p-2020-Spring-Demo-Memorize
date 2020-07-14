//
//  ContentView.swift
//  Memorize
//
//  Created by Jasper Wang on 2020-05-30.
//  Copyright © 2020 Jasper Wang. All rights reserved.
//

import SwiftUI

// The ContentView will be created by SceneDelegate in the app lifecycle
struct ContentView: View {
    @ObservedObject // invokes re-draw on View upon the object calls objectWillChange
    var viewModel: EmojiMemoryGame
    
    // body here is referred to as a system and should never be invoked in code
    var body: some View {
        // vars cannot be created in these view builders, but vars can be created outside and used inside
//        return HStack { // HStack initializes with a function parameter
//            // Attaching model to view via ViewModel
//            ForEach(viewModel.cards) { card in // any iterations of identifiables (i.e. can identify one element from another) can be put into ForEach
//                CardView(card: card).onTapGesture{
//                    self.viewModel.chooseCard(card: card) // expressing intents
//                }
//            }
//        }
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture{
                self.viewModel.chooseCard(card: card) // expressing intents
            }
        }
        .padding() // around the outer stack
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth) // one view
                    Text(self.card.content) // another view
                } else {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height * self.fontScaleFactor)))

        })
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
