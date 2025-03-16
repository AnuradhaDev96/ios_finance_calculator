//
//  SimpleInterestRateView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import SwiftUI

struct SimpleInterestRateView: View {
    // Text ediitors
    @State private var principalAmount: String = ""
    @State private var futureValue: String = ""
    @State private var duration: String = ""
    
    // Toggle
    @ObservedObject var result: SimpleInterestRateResultViewModel
    
    var isFormInvalid: Bool {
        return principalAmount.isEmpty || futureValue.isEmpty || duration.isEmpty
    }
    
    var canResetForm: Bool {
        return !principalAmount.isEmpty || !futureValue.isEmpty || !duration.isEmpty
    }
    
    var body: some View {
        Section(header: Text("Variables for Simple Interest Rate")) {
            VStack{
                CustomNumberField(placeholder: "Principal Amount", text: $principalAmount)
                CustomNumberField(placeholder: "Future Value", text: $futureValue)
                CustomNumberField(placeholder: "Duration", text: $duration, suffix: "years")
                
                Button(action: {
                    hideKeyboard()
                    result.calculateResult(futureValue: futureValue, periodInYears: duration, principal: principalAmount)
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
                
                if (canResetForm) {
                    ResetButton(action: resetForm)
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .alert(result.alertDetails.alertKey, isPresented: $result.alertDetails.isPresented) {}
            message: {
                Text(result.alertDetails.message)
            }
        }
    }
    
    func resetForm() {
        principalAmount = ""
        futureValue = ""
        duration = ""
        result.resetModel()
    }
}

struct SimpleInterestRateResultCard: View {
    @ObservedObject var result: SimpleInterestRateResultViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Simple Interest Rate")
                .font(.headline)
                .foregroundColor(.primary)

            Text("\(String(format: "%.2f", result.interestRateAnswer))%")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
