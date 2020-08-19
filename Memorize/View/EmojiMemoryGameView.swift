//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rafaela da Silva Cunha Montanari on 04/08/20.
//  Copyright © 2020 Rafaela da Silva Cunha Montanari. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View { // "View" é um protocolo, por isso tem acesso ao padding, foregroundColor e font abaixo
    @ObservedObject var viewModel: EmojiMemoryGame //redesenhar toda vez que a viewModel publicar que o model mudou, funciona aqui pq o "EmojiMemoryGame" utilizou o protocolo ObservableObject. Redesenha apenas o que mudou!!
    var body: some View { // var body é uma variavel computada, ela tem chaves
        HStack{
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding() //pode ser colocado valores entre o parenteses, mas é bom usar o padrao
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .stroke(lineWidth: 3)
                    Text(self.card.content)
                } else {
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .fill()
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * self.fontScaleFactor))
        }
    }
    // MARK: -Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
