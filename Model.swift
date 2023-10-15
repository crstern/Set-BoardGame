//
//  SetGameModel.swift
//  Set
//
//  Created by Cristian Stern on 07.10.2023.
//

import Foundation

struct Model{
    private(set) var cards: Array<Card>
    private(set) var deck: Array<Card>
    private let initDeckSize: Int = 12
    
    func getChsoenCards() -> [Card]{
        return deck.filter { $0.isTouched == true }
    }
    
    mutating func resetCards(){
        deck.indices.forEach { deck[$0].isTouched = false }
    }
    
    mutating func addCards(){
        deck.transfer(3, &cards)
    }
    
    init(){
        cards = []
        deck = []
        for symbol in Attribute.allCases{
            for color in Attribute.allCases{
                for number in 1...3{
                    for shade in Attribute.allCases{
                        cards.append(Card(symbol, color, number, shade))
                    }
                }
            }
        }
        cards.shuffle()
        deck.transfer(initDeckSize, &cards)
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = deck.firstIndex(where: {$0.id == card.id}){
            deck[chosenIndex].isTouched.toggle()
            let chosenCards = getChsoenCards()
            if chosenCards.count == 3{
                if isSet(chosenCards[0], chosenCards[1], chosenCards[2]){
                    deck.removeAll{ card in chosenCards.contains { $0.id == card.id }}
                }else {
                    print("NUU SET")
                }
                resetCards()
            }
        }
    }
    
    func isSet(_ c1: Card, _ c2: Card, _ c3: Card) -> Bool{
        return areSetAttributes(c1.color, c2.color, c3.color) &&
        areSetAttributes(c1.shade, c2.shade, c3.shade) &&
        areSetAttributes(c1.symbol, c2.symbol, c3.symbol) &&
        areSetAttributes(c1.number, c2.number, c3.number)
    }
    
    struct Card: Identifiable{
        var id: String
        
        let symbol: Attribute
        let color: Attribute
        let number: Int
        let shade: Attribute
        var isTouched: Bool = false
        var isMatched: Bool = false
        
        init(_ symbol: Attribute, _ color: Attribute, _ number: Int, _ shade: Attribute) {
            self.id = "\(symbol)\(color)\(number)\(shade)"
            self.symbol = symbol
            self.color = color
            self.number = number
            self.shade = shade
        }
    }
    
    enum Attribute: CaseIterable{        
        case one, two, three
    }
}

extension Array{
    mutating func transfer(_ size: Int, _ oldArray: inout Array){
        for _ in 0..<size{
            self.append(oldArray.removeFirst())
        }
    }
   
}

func areSetAttributes<Item: Equatable>(_ a: Item, _ b: Item, _ c: Item) -> Bool{
    return (a == b && b == c) || (a != b && b != c && a != c)
}
