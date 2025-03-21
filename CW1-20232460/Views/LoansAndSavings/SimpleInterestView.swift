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
    
    var canResetForm: Bool {
        return !principalAmount.isEmpty || !interestRate.isEmpty || !duration.isEmpty
    }
    
    var body: some View {
        Section(header: Text("Variables for Simple Interest"),
                footer: HStack {
            Spacer()
            Button(action: {}) {
                Text("How this works?")
            }
        }) {
            VStack{
                CustomNumberField(placeholder: "Principal Amount", text: $principalAmount)
                CustomNumberField(placeholder: "Interest Rate", text: $interestRate, suffix: "%")
                CustomNumberField(placeholder: "Duration", text: $duration, suffix: "years")
                
                Toggle("Show Future Value", isOn: $result.showFutureValue).padding(.top, 10)
                
                Button(action: {
                    hideKeyboard()
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
                
                if (canResetForm) {
                    ResetButton(action: resetForm)
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .alert(result.alertDetails.alertKey, isPresented: $result.alertDetails.isPresented) {}
            message: {
                Text(result.alertDetails.message)
            }
            //            .toolbar {
            //                ToolbarItemGroup(placement: .keyboard, content: {
            //                    Spacer()
            //                    Button("Done") {
            //                        hideKeyboard()
            //                    }.font(.headline)
            //                })
            //            }
        }
    }
    
    private func resetForm() {
        principalAmount = ""
        interestRate = ""
        duration = ""
        result.resetModel()
    }
}

struct SimpleInterestResultCard: View {
    @ObservedObject var result: SimpleInterestResultViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Simple Interest")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Rs.\(String(format: "%.2f", result.interestAnswer))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            if (result.showFutureValue) {
                VStack(alignment: .center, spacing: 2) {
                    Spacer()
                    Text("Future Value")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Rs.\(String(format: "%.2f", result.futureValueAnswer))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
