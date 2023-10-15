//
//  SetViewModel.swift
//  Set
//
//  Created by Cristian Stern on 05.10.2023.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published private var model = SetViewModel.createSetGame()
    
    static func createSetGame() -> Model{
        return Model()
    }
    
    var deck: [Model.Card]{
        return model.deck
    }
    
    func choose(_ card: Model.Card){
        model.choose(card)
    }
    
    func newGame(){
        model = SetViewModel.createSetGame()
    }
    
    func addCards(){
        model.addCards()
    }
}
