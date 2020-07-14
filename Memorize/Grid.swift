//
//  Grid.swift
//  Memorize
//
//  Created by Jasper Wang on 2020-07-13.
//  Copyright © 2020 Jasper Wang. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    // @escaping is needed to ensure that the viewForItem can be assigned properly (otherwise error arised due to not using the function)
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
