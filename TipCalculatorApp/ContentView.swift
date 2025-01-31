//
//  ContentView.swift
//  TipCalculatorApp
//
//  Created by DivyaCharan JVS on 26/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 50.0 // Bill Amount
    @State private var tipPercentage: Double = 15.0 // Tip Percentage
    @State private var numberOfPeople: Double = 1.0 // Number of people
    @State private var showResults: Bool = false // Show results
    @State private var currencyIndex: Int = 0 // current currency index
    
    private let currencies = ["USD", "EUR", "INR"] // Currencies Array
    private let currencySymbols: [String: String] = [
        "USD": "$",
        "EUR": "€",
        "INR": "₹"
    ] // Currencies Symbols dictionary
    
    
    private var selectedCurrency: String {
        return currencies[currencyIndex]
    } // Return the selected currency index
    private var selectedSymbol: String {
        return currencySymbols[selectedCurrency] ?? selectedCurrency
    } // Return the selected currency symbol
    
    private var tipAmount: Double {
        return billAmount * tipPercentage / 100
    } // Return the tip amount
    
    private var totalAmount: Double {
        return billAmount + tipAmount
    } // Return the total Amount including the tip
    
    private var amountPerPerson: Double {
        return totalAmount / numberOfPeople
    } // Return the ampunt per person
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Tip Calculator")
                .font(.largeTitle)
                .bold()
                .padding()
            // Currency Selector
            Button(action: {
                currencyIndex = (currencyIndex + 1) % currencies.count
            }) {
                Circle()
                    .fill(Color.black.opacity(0.8))
                    .frame(width: 90, height: 90)
                    .overlay(
                        Text(selectedSymbol)
                            .foregroundColor(.white)
                            .font(.system(size: 65))
                    )
            }
            .padding()
            // Bill Amount Slider
            VStack{
                Text("Bill Amount").bold()
                Text("\(billAmount, format: .currency(code: selectedCurrency))").foregroundStyle(.purple)
                Slider(value: $billAmount, in: 0...500, step: 1).accentColor(.purple)
            }
            .padding()
            
            // Tip Percentage Slider
            VStack {
                Text("Tip Percentage").bold()
                Text("\(Int(tipPercentage))%").foregroundStyle(.green)
                Slider(value: $tipPercentage, in: 0...30, step: 1).accentColor(.green)
            }
            .padding()
            
            // Number of People Slider
            VStack {
                Text("Number of People").bold()
                Text("\(Int(numberOfPeople))").foregroundStyle(.yellow)
                Slider(value: $numberOfPeople, in: 1...20, step: 1).accentColor(.yellow)
            }
            .padding()
            
            // Show Results Button
            Button(action: {
                showResults.toggle()
            }) {
                Text(showResults ? "Hide Results" : "Calculate")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(showResults ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if billAmount == 0 && showResults  {
                Text("Please select an amount to view the results.")
                    .foregroundColor(.red)
                    .padding()
                
            }
            
            // Results Section
            if showResults && billAmount != 0 {
                VStack(spacing: 15) {
                    Text("Tip Amount: \(tipAmount, format: .currency(code: selectedCurrency))")
                    Text("Total Amount: \(totalAmount, format: .currency(code: selectedCurrency))")
                    Text("Amount Per Person: \(amountPerPerson, format: .currency(code: selectedCurrency))")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 5)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct TipCalculatorApp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

