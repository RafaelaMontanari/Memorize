//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rafaela da Silva Cunha Montanari on 11/08/20.
//  Copyright © 2020 Rafaela da Silva Cunha Montanari. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { //portanto sou obrigado a colocar o tipo generico aqui
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {cards.indices.filter {cards[$0].isFaceUp}.only}
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) { // como esta funcao pretende escolher uma carta, que foi criada como stryct, e mudar a situacao dela, TEMOS que informar o swift que haverá alteracao num valor de struct, portnto TEMOS que usar "mutating". Isso só vale para structs, para classes nao é necessario pq classes sao ponteiros e nao copia dos valores
        print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            // if para desembrulhar, se retornar vazio nem é executado
            if let potencialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potencialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potencialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
