//
//  ContentView.swift
//  SwiftUINinthExercise
//
//  Created by Лада Зудова on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    let centerWidth = UIScreen.main.bounds.width/2
    let centerHeight = UIScreen.main.bounds.height/2
    
    @State var position = CGSize(width: 0, height: 0)
    
    var body: some View {
        Canvas { context, size in
            let firstCircle = context.resolveSymbol(id: 0)!
            let secondCircle = context.resolveSymbol(id: 1)!
            
            context.addFilter(.alphaThreshold(min: 0.2))
            context.addFilter(.blur(radius: 30))
            
            context.drawLayer { contextSecond in
                contextSecond.draw(firstCircle, at: .init(x: centerWidth, y: centerHeight))
                contextSecond.draw(secondCircle, at: .init(x: centerWidth, y: centerHeight))
            }
        } symbols: {
            Circle()
                .frame(width: 80, height: 80, alignment: .center)
                .tag(0)
            Circle()
                .frame(width: 80, height: 80, alignment: .center)
                .offset(x: position.width, y: position.height)
                .tag(1)
        }
        .gesture(DragGesture()
            .onChanged({ value in
                position = value.translation
            })
            .onEnded({ value in
                position = CGSize(width: 0, height: 0)
            })
        )
        .animation(.spring(dampingFraction: 0.6), value: self.position)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
