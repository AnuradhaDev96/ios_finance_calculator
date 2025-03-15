//
//  SimpleInterestView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import SwiftUI

struct SimpleInterestView: View {
    // Text ediitors
    @State private var principalAmount: String = ""
    @State private var interestRate: String = ""
    @State private var duration: String = ""
    
    // Toggle
    @ObservedObject var result: SimpleInterestResultViewModel
    
    var isFormInvalid: Bool {
        return principalAmount.isEmpty || interestRate.isEmpty || duration.isEmpty
    }
    
    var body: some View {
        Section(header: Text("User Inputs")) {
            VStack{
                CustomNumberField(placeholder: "Principal Amount", text: $principalAmount)
                CustomNumberField(placeholder: "Interest Rate", text: $interestRate, suffix: "%")
                CustomNumberField(placeholder: "Duration", text: $duration, suffix: "years")
                
                Toggle("Show Future Value", isOn: $result.showFutureValue).padding(.top, 10)
                
                Button(action: {
                    result.calculateResult(annualInterest: interestRate, periodInYears: duration, principal: principalAmount)
                }) {
                    Text("Calculate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .disabled(isFormInvalid)
                        .background(isFormInvalid ? Color.gray.opacity(0.7) : Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}
