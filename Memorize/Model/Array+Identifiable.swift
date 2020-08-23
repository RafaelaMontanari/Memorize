//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Rafaela da Silva Cunha Montanari on 23/08/20.
//  Copyright © 2020 Rafaela da Silva Cunha Montanari. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex (matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
