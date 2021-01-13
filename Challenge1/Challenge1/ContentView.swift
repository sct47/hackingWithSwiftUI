//
//  ContentView.swift
//  Challenge1
//
//  Created by Scott Murray on 13/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var timeInput = ""
    @State private var inputMeasurement = 0
    @State private var outputMeasurement = 0
    
    let timeTypes = ["seconds", "minutes", "hours", "days"]
    
    var outputTime: [Double] {
        let timeValue = Double(timeInput) ?? 0
        if inputMeasurement == 0 {
            return [timeValue, timeValue/60, timeValue/3600, timeValue/86400]
        } else if inputMeasurement == 1 {
            return [timeValue*60, timeValue, timeValue/60, timeValue/1440]
        } else if inputMeasurement == 2 {
            return [timeValue*3600, timeValue*60, timeValue, timeValue/24]
        } else {
            return [timeValue*84600, timeValue*1440, timeValue*24, timeValue]
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter Time and select measurement")) {
                    TextField("Enter an amount of time", text: $timeInput).keyboardType(.decimalPad)
                    
                    Picker("Input Measurement", selection: $inputMeasurement) {
                        ForEach(0 ..< timeTypes.count) {
                            Text("\(self.timeTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Enter measurement to display time in")) {
                    Picker("Output Measurement", selection: $outputMeasurement) {
                        ForEach(0 ..< timeTypes.count) {
                            Text("\(self.timeTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("\(outputTime[outputMeasurement], specifier: "%g") \(timeTypes[outputMeasurement])")
                }
            }
            .navigationBarTitle("Time Converter")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
