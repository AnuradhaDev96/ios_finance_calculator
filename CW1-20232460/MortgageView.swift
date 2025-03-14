//
//  MortgageView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-14.
//

import SwiftUI

struct MortgageView: View {
    @State private var loanAmount: String = ""
    @State private var interest: String = ""
    @State private var payment: String = ""
    @State private var noOfYears: String = ""
    
    @FocusState private var isLoanAmountFocused: Bool
    @FocusState private var isInterestFocused: Bool
    @FocusState private var isPaymentFocused: Bool
    @FocusState private var isNoOfYearsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    CustomNumberField(placeholder: "Loan Amount", text: $loanAmount, isFocused: $isLoanAmountFocused)
                    CustomNumberField(placeholder: "Interest", text: $interest, isFocused: $isInterestFocused)
                    CustomNumberField(placeholder: "Payment", text: $payment, isFocused: $isPaymentFocused)
                    CustomNumberField(placeholder: "No. of Years", text: $noOfYears, isFocused: $isNoOfYearsFocused)
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Makes title smaller
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Mortgage")
                        .font(.system(size: 18, weight: .bold)) // Reduce font size to fit width
                        .lineLimit(1) // Ensure it's in one line
                        .minimumScaleFactor(0.7) // Adjusts font size dynamically if needed
                }
            }
        }
    }
}
