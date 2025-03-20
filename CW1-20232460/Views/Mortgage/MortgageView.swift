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
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CustomNumberField(placeholder: "Loan Amount", text: $loanAmount)
                    CustomNumberField(placeholder: "Interest", text: $interest)
                    CustomNumberField(placeholder: "Payment", text: $payment)
                    CustomNumberField(placeholder: "No. of Years", text: $noOfYears)
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

#Preview {
    MortgageView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
