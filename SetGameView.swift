//
//  ContentView.swift
//  Set
//
//  Created by Cristian Stern on 05.10.2023.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetViewModel
    private let cardAspectRatio: CGFloat = 3/4
    
    var body: some View {
        VStack {
            cards
            Spacer()
            HStack(spacing: 100, content: {
                addCards
                newGame
            })
            
        }.padding()
    }
    
    private var cards: some View{
        AspectVGrid(viewModel.deck, aspectRatio: cardAspectRatio){ card in
            CardView(card)
                .onTapGesture {
                viewModel.choose(card)
            }
        }
    }
    
    private var newGame: some View{
        Button("New Game"){
            viewModel.newGame()
        }
    }
    
    private var addCards: some View{
        Button("Add cards"){
            viewModel.addCards()
        }
    }
}

struct CardView: View{
    let card: Model.Card
    
    init(_ card: Model.Card){
        self.card = card
    }
    
    private var color: Color{
        switch card.color{
        case .one: return .purple
        case .two: return .green
        case .three: return .red
        }
    }
    
    @ViewBuilder
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius:12)
                .strokeBorder(lineWidth:3)
                .shadow(radius: card.isTouched ? 5 : 0)
            VStack{
                ForEach(0..<card.number, id: \.self){ _ in
                    buildShape()
                        .frame(width: 50, height: 20)
                        .aspectRatio(2/3, contentMode: .fit)

                }
            }
        }
        .padding(card.isTouched ? 4 : 9)
        .foregroundColor(card.isTouched ? .cyan : .orange)
        .background(.white)
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    @ViewBuilder
    func buildShape() -> some View{
        switch card.symbol{
        case .one: fillShading(shape: Capsule())
        case .two: fillShading(shape: Circle())
        case .three: fillShading(shape: Rectangle())
        }
    }
    
    func cardColor(_ attribute: Model.Attribute) -> SwiftUI.Color{
        switch attribute{
        case .one:
            SwiftUI.Color.purple
        case .two:
            SwiftUI.Color.green
        case .three:
            SwiftUI.Color.red
        }
    }
    
    @ViewBuilder
    func fillShading<setShape:Shape>(shape: setShape) -> some View{
        switch card.shade {
        case .one: shape.solid(color)
        case .two: shape.strip(color)
        case .three: shape.open(color)
        }
    }
}

extension Shape{
    func solid(_ color: Color) -> some View{
        self.fill().foregroundColor(color)
    }
    
    func strip(_ color: Color) -> some View{
        return ZStack{
            self.fill().stroke(color)
                .foregroundColor(color.opacity(0.3))
            self.stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/).foregroundColor(color)
        }
    }
    
    func open(_ color: Color) -> some View{
        self.stroke(lineWidth: 2)
            .background(.white).foregroundColor(color)

    }
}
    
    


#Preview {
    SetGameView(viewModel: SetViewModel())
}
