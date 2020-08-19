//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rafaela da Silva Cunha Montanari on 11/08/20.
//  Copyright © 2020 Rafaela da Silva Cunha Montanari. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> { //portanto sou obrigado a colocar o tipo generico aqui
    var cards: Array<Card>
    
    mutating func choose(card: Card) { // como esta funcao pretende escolher uma carta, que foi criada como stryct, e mudar a situacao dela, TEMOS que informar o swift que haverá alteracao num valor de struct, portnto TEMOS que usar "mutating". Isso só vale para structs, para classes nao é necessario pq classes sao ponteiros e nao copia dos valores
        print("card chosen: \(card)")
        let chosenIndex: Int = self.index(of: card) //argumento interno
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int { //"of card" argumento interno e argumento externo
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id { // argumento externo
                return index
            }
        }
        return 0 // TODO: bogus!! (falso!!)
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>() //array de cartas vazio()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable { // "Identifiable" é muito importante para recuperar o cartao selecionado através do ID e depois identificar qual deles foi alterado para redesenhar o view
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent //inventei um tipo generico, pq o card pode conter um Int, uma String, uma imagem...
        var id: Int
    }
}
