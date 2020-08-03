//
//  Grid.swift
//  Memorize
//
//  Created by Jasper Wang on 2020-07-13.
//  Copyright © 2020 Jasper Wang. All rights reserved.
//

import SwiftUI

// Item needs to be Identifiable to be iterated in ForEach. Here the generics are connected to protocols to give constrains
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    // @escaping is needed to ensure that the viewForItem can be assigned properly (otherwise error arised due to not using the function)
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = self.items.firstIndex(matching: item)! // index should never be nil
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
        
    }
}
