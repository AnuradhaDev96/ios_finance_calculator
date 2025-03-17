//
//  InitialInvestmentView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import SwiftUI

struct InitialInvestmentView: View {
    // Text ediitors
    @State private var durationInYears: String = ""
    @State private var futureValue: String = ""
    @State private var interestRate: String = ""
    
    @ObservedObject var result: SimpleInterestPrincipalResultViewModel
    
    var isFormInvalid: Bool {
        return durationInYears.isEmpty || futureValue.isEmpty || interestRate.isEmpty
    }
    
    var canResetForm: Bool {
        return !durationInYears.isEmpty || !futureValue.isEmpty || !interestRate.isEmpty
    }
    
    var body: some View {
        Section(header: Text("Variables for Initial Investment")) {
            VStack{
                CustomNumberField(placeholder: "Future Value", text: $futureValue)
                CustomNumberField(placeholder: "Interest Rate", text: $interestRate, suffix: "%")
                CustomNumberField(placeholder: "Duration", text: $durationInYears, suffix: "years")
                
                Button(action: {
                    hideKeyboard()
                    result.calculateResult(futureValue: futureValue, interestRate: interestRate, durationInYears: durationInYears)
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
        durationInYears = ""
        futureValue = ""
        interestRate = ""
        result.resetModel()
    }
}

struct InitialInvestmentResultCard: View {
    @ObservedObject var result: SimpleInterestPrincipalResultViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Initial Investment\n(Principal Amount)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)

            Text("Rs.\(String(format: "%.2f", result.initialInvestmentAnswer))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
