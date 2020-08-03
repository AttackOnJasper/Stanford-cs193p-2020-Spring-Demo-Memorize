//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Jasper Wang on 2020-07-14.
//  Copyright © 2020 Jasper Wang. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? { // Int? is an optional type
        for index in 0..<self.count {
            if (self[index].id == matching.id) {
                return index
            }
        }
        return nil
    }
}
