//
//  ContentView.swift
//  Hacking-with-iOS-SwiftUI-Edition
//
//  Created by enesaliovur on 5.04.2023.
//

import SwiftUI

// TODO: ekrana tıklayınca klavyeyi nasıl kapatırım?

struct WeSplitView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isKeyboardVisible:Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ??  "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isKeyboardVisible)
                    
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.automatic)
                    
                }
                Section {
                    Picker("Tip percentange", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?").textCase(.uppercase)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isKeyboardVisible = false
                    }
                }
            }
        }
       
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}
