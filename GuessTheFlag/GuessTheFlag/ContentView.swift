//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Scott Murray on 15/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var playerScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctGuess = false
    @State private var rotation = 0.0
    @State private var fade = 1.0
    @State private var shakes = 0
    @State private var guess = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation() {
                            self.flagTapped(number)
                            if correctGuess {
                                self.rotation += 360
                            } else {
                                self.shakes += 1
                            }
                            self.fade = 0.2
//                            self.askQuestion()
                        }
                        
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .flagImage()
                            .rotation3DEffect(number == correctAnswer ? .degrees(rotation) : .degrees(0), axis: (x: 0, y: 1, z:0))
                            .opacity(number != correctAnswer ? fade : 1)
                            .modifier(number == guess ? Shake(animatableData: CGFloat(shakes)) : Shake(animatableData: CGFloat(0)))
                    }
                }
                
                Text("Score: \(self.playerScore)")
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .font(.title2)
                
                
                    
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(self.playerScore)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 1
            correctGuess = true
        } else {
            scoreTitle = "Wrong, thats the \(countries[number]) flag!"
            playerScore -= 1
            correctGuess = false
            guess = number
        }
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
          self.showingScore = true
        })
    }
    
    func askQuestion() {
        countries.shuffle()
        fade = 1
        rotation = 0
        correctGuess = false
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule()
                        .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct WrongPick: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule()
                        .stroke(Color.red, lineWidth: 3))
            .shadow(color: .red, radius: 5)
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

extension View {
    func flagImage() -> some View {
        self.modifier(FlagImage())
    }
    
    func wrongPick() -> some View {
        self.modifier(WrongPick())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
