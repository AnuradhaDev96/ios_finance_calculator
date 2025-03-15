//
//  SimpleInterestView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import SwiftUI

struct SimpleInterestView: View {
    // Text ediitors
    @State private var presentValue: String = ""
    @State private var futureValue: String = ""
    @State private var interest: String = ""
    @State private var payment: String = ""
    @State private var paymentsPerYear: String = ""
    @State private var compoundsPerYear: String = ""
    
    // Toggle
    @ObservedObject var result: InterestResultViewModel
    
    // Focus states
    @FocusState private var isPresentFocused: Bool
    @FocusState private var isFutureFocused: Bool
    @FocusState private var isInterestFocused: Bool
    @FocusState private var isPaymentFocused: Bool
    @FocusState private var isPaymentsPerYearFocused: Bool
    @FocusState private var isCompundsPerYearFocused: Bool
    
    var body: some View {
        Section(header: Text("User Inputs")) {
            VStack{
                
                CustomNumberField(placeholder: "Principal Amount", text: $presentValue, isFocused: $isPresentFocused)
                CustomNumberField(placeholder: "Interest Rate", text: $interest, isFocused: $isInterestFocused, suffix: "%")
                CustomNumberField(placeholder: "Duration", text: $paymentsPerYear, isFocused: $isPaymentsPerYearFocused, suffix: "years")
                
                Toggle("Show Future Value", isOn: $result.showFutureValue).padding(.top, 10)
                
                Button(action: {
//                    removeFocus()
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    print("clicked calc")
                    result.calculateResult(annualInterest: interest, periodInYears: paymentsPerYear, principal: presentValue)
                }) {
                    Text("Calculate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }.padding()
                
                
            }
//            .gesture(
//                TapGesture().onEnded(removeFocus)
//            )
        }
    }
    
    private func removeFocus() -> Void {
        isPresentFocused = false
        isFutureFocused = false
        isInterestFocused = false
        isPaymentFocused = false
        isPaymentsPerYearFocused = false
        isCompundsPerYearFocused = false
    }
}
