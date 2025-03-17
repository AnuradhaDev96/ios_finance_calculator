//
//  InvestmentDurationView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import SwiftUI

struct InvestmentDurationView: View {
    // Text ediitors
    @State private var principalAmount: String = ""
    @State private var futureValue: String = ""
    @State private var interestRate: String = ""
    
    @ObservedObject var result: SimpleInterestInvestmentDurationResultViewModel
    
    var isFormInvalid: Bool {
        return principalAmount.isEmpty || futureValue.isEmpty || interestRate.isEmpty
    }
    
    var canResetForm: Bool {
        return !principalAmount.isEmpty || !futureValue.isEmpty || !interestRate.isEmpty
    }
    
    var body: some View {
        Section(header: Text("Variables for Investment Duration")) {
            VStack{
                CustomNumberField(placeholder: "Principal Amount", text: $principalAmount)
                CustomNumberField(placeholder: "Future Value", text: $futureValue)
                CustomNumberField(placeholder: "Interest Rate", text: $interestRate, suffix: "%")
                
                Button(action: {
                    hideKeyboard()
                    result.calculateResult(futureValue: futureValue, interestRate: interestRate, principal: principalAmount)
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
        interestRate = ""
        result.resetModel()
    }
}

struct InvestmentDurationResultCard: View {
    @ObservedObject var result: SimpleInterestInvestmentDurationResultViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Investment Duration")
                .font(.headline)
                .foregroundColor(.primary)

            Text("\(String(format: "%.2f", result.investmentDurationAnswer)) years")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
