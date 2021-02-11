//
//  ContentView.swift
//  TimesTables
//
//  Created by Scott Murray on 10/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var one = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @State private var two = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
    @State private var three = [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30]
    @State private var four = [0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40]
    @State private var five = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
    @State private var six = [0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60]
    @State private var seven = [0, 7, 14, 21, 28, 35, 42, 49, 56, 63, 70]
    @State private var eight = [0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80]
    @State private var nine = [0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90]
    @State private var ten = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    @State private var eleven = [0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110]
    @State private var twelve = [0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120]
    @State private var game = []
    @State private var choices = [Int]()
    @State private var questions = 0
    @State private var numberOfQuestions = ["1", "5", "10", "All"]
    let columns = [GridItem(.adaptive(minimum: 80))]
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    var body: some View {
        Form {
            Section(header: Text("Select times tables for practice")) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(data, id: \.self) { number in
                            Button(action: {
                                self.numberTapped(number)
                            }){
                                Image(systemName: choices.contains(number) ? "\(number).square.fill" : "\(number).square")
//                                    .foregroundColor(choices.contains(number) ? Color.blue : Color.black)
                            }
                        }
                    }
                }
            }

            Section(header: Text("How many questions would you like?")) {
                Picker("Number of Questions", selection: $questions) {
                    ForEach(0 ..< numberOfQuestions.count) {
                        Text("\(numberOfQuestions[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
    
    func numberTapped(_ number: Int) {
        if self.choices.contains(number) {
            choices.removeAll { value in
                return value == number
            }
        } else {
            choices.append(number)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
