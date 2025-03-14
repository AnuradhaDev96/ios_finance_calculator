//
//  LoansAndSavingsView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-13.
//

import SwiftUI

struct LoansAndSavingsView: View {
    // Text ediitors
    @State private var presentValue: String = ""
    @State private var futureValue: String = ""
    @State private var interest: String = ""
    @State private var payment: String = ""
    @State private var paymentsPerYear: String = ""
    @State private var compoundsPerYear: String = ""
    
    // Toggle
    @State private var isEnd: Bool = true
    @StateObject private var selectedValue: ResultSelectionViewModel = ResultSelectionViewModel()
    
    // Focus states
    @FocusState private var isPresentFocused: Bool
    @FocusState private var isFutureFocused: Bool
    @FocusState private var isInterestFocused: Bool
    @FocusState private var isPaymentFocused: Bool
    @FocusState private var isPaymentsPerYearFocused: Bool
    @FocusState private var isCompundsPerYearFocused: Bool

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What do you need to calculate?")) {
                    ResultSelectionChips(selectedValue: selectedValue)
                        .listRowBackground(Color.clear)
                }
                Section(header: Text("User Inputs")) {
                    CustomNumberField(placeholder: "Present Value", text: $presentValue, isFocused: $isPresentFocused)
                    CustomNumberField(placeholder: "Future Value", text: $futureValue, isFocused: $isFutureFocused)
                    CustomNumberField(placeholder: "Interest", text: $interest, isFocused: $isInterestFocused)
                    CustomNumberField(placeholder: "Payment", text: $payment, isFocused: $isPaymentFocused)
                    CustomNumberField(placeholder: "No. of Payments Per Year", text: $paymentsPerYear, isFocused: $isPaymentsPerYearFocused)
                    CustomNumberField(placeholder: "Compounds Per Year", text: $compoundsPerYear, isFocused: $isCompundsPerYearFocused)
                    HStack {
                        Toggle("", isOn: $isEnd)
                        Text("End")
                    }.padding(.top, 10)
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
            }.gesture(
                TapGesture().onEnded(removeFocus)
            )
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

enum ResultType: String, CaseIterable, Identifiable {
    case simple = "Simple Interest"
    case compound = "Compound Interest"
    case present = "Present Value"
    case future = "Future Value"
    
    var id: String {self.rawValue}
}

//class ResultTypeClass: Identifiable {
//    let id = UUID()
//    let rowValue: String = ""
//    @State var isSelected: Bool = false
//}

#Preview {
    LoansAndSavingsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
