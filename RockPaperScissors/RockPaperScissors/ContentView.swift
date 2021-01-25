//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Scott Murray on 22/1/21.
//

import SwiftUI

struct ContentView: View {
    
    let game = ["Rock", "Paper", "Scissors"]
    @State private var gameChoice = Int.random(in: 0 ... 2)
    @State private var shouldWin = Bool.random
    @State private var playerScore = 0
    @State private var scoreTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Player Score: \(playerScore)")
                Text("Computers Move: \(game[gameChoice])")
                
                HStack {
                    ForEach(0 ..< game.count) { number in
                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            Text("\(game[number])")
                                .frame(width: 100, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .gameButtons()
                                
                        }
                    }
                }
            }
        }
        .navigationTitle("Rock Paper Scissors")
    }
    
    func buttonTapped(_ number: Int) {
        if shouldWin() {
            // handle when user should win
            switch gameChoice {
            case 0:
                if number == 1 {
                    playerScore += 1
                    scoreTitle = "You win!"
                } else if number == 0 {
                    scoreTitle = "Draw!"
                } else {
                    playerScore -= 1
                    scoreTitle = "You lose!"
                }
            case 1:
                if number == 2 {
                    playerScore += 1
                    scoreTitle = "You win!"
                } else if number == 1 {
                    scoreTitle = "Draw!"
                } else {
                    playerScore -= 0
                    scoreTitle = "You lose!"
                }
            case 2:
                if number == 0 {
                    playerScore += 1
                    scoreTitle = "You win!"
                } else if number == 2 {
                    scoreTitle = "Draw!"
                } else {
                    playerScore -= 0
                    scoreTitle = "You lose!"
                }
            default:
                return
            }
        } else {
            // handle when they should lose
        }
    }
}

struct GameButtons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule()
                        .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func gameButtons() -> some View {
        self.modifier(GameButtons())
    }
}
