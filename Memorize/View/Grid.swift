//
//  Grid.swift
//  Memorize
//
//  Created by Rafaela da Silva Cunha Montanari on 20/08/20.
//  Copyright © 2020 Rafaela da Silva Cunha Montanari. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View { //(where Item: Identifiable) o item tem que ser identificavel para nao dar erro (nao é possivel converter o valor do tipo matriz de item para tipo de argumento esperado Range<Int>) no ForEach(items) por ser um array. (ItemView: View) o itemview deve ser uma view para que esse erro nao ocorra: “Tipo de retorno da propriedade ‘body’, requer que ‘ItemView’esteja em conformidade com ‘View’.”
    //desta forma conectando elementos genericos com protocolos
    var items: [Item]
    var viewForItem: (Item) -> ItemView // escapa do init pq o calocamos neste var
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) { //o @escaping faz com que esta funcao "escape" deste inicializador sem ser chamada
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in  //GeometryReader para o container saber o quanto de espaco ele tem para depois distribuir entre seus elementos
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
        
    func body(for layout: GridLayout) -> some View { // criar esta funcao aqui para nao precisar colocar o self em "ForEach(self.items)"
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)! // este valor é opcional (Array+Identifiable)
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}
