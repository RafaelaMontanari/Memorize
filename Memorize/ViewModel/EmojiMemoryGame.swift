//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rafaela da Silva Cunha Montanari on 11/08/20.
//  Copyright © 2020 Rafaela da Silva Cunha Montanari. All rights reserved.
//

import SwiftUI

/* func createCardContent(pairIndex: Int) -> String {
    return "😀"
}
 
 a funcao acima foi embutida dentro da private var model deta forma

    MemoryGame<String>(numberOfPairsOfCards: 2, cardContentFactory: {(pairIndex: Int) -> String in
        return "😀"
})
 sendo assim ela é uma closure, uma funcao embutida
 
 como esta entre chaves entao sabeboms que é o ultimo argumento, sendo assim nao precisa escrever "cardContentFactory: ", o swift ja sabe
 também nao precisamo escrever ": Int", nem "-> String" e nem "return", o swift inferi tipos entao ele ja sabe dessas informacoes
 o proprio "pairIndex"pode ser substituido por _
 ficando por fim desta forma:
 private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2) { _ in "😀"}
 Mas nao queremos que nas cartas apareca somente 😀, queremos um Array de coisas, portanto:
*/

class EmojiMemoryGame: ObservableObject { //tornando reactive. Só funciona com class
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame() //o wrapper @Published: é publicado sempre que o modelo muda. Pode colocar issona variavel ou "objectWillChange.send()" em todas as funcoes
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {pairIndex in
        return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intenções
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
