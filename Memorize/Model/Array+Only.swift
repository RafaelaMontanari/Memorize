//
//  Array+Only.swift
//  Memorize
//
//  Created by Rafaela da Silva Cunha Montanari on 23/08/20.
//  Copyright © 2020 Rafaela da Silva Cunha Montanari. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
