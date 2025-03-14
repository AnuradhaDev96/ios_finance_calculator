//
//  MortgageView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-14.
//

import SwiftUI

struct MortgageView: View {
    @State private var presentValue: String = ""
    @State private var futureValue: String = ""
    @State private var interest: String = ""
    @State private var payment: String = ""
    @State private var paymentsPerYear: String = ""
    @State private var compoundsPerYear: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
//                    CustomNumberField(placeholder: "Present Value", text: $presentValue)
//                    CustomNumberField(placeholder: "Future Value", text: $futureValue)
//                    CustomNumberField(placeholder: "Interest", text: $interest)
//                    CustomNumberField(placeholder: "Payment", text: $payment)
//                    CustomNumberField(placeholder: "No. of Payments", text: $paymentsPerYear)
//                    CustomNumberField(placeholder: "Compounds Per Year", text: $compoundsPerYear)
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Makes title smaller
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Compound Loans and Savings")
                        .font(.system(size: 18, weight: .bold)) // Reduce font size to fit width
                        .lineLimit(1) // Ensure it's in one line
                        .minimumScaleFactor(0.7) // Adjusts font size dynamically if needed
                }
            }
        }
    }
}
