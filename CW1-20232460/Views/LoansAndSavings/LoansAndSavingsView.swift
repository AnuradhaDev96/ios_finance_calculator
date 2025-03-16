//
//  LoansAndSavingsView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-13.
//

import SwiftUI

struct LoansAndSavingsView: View {
    @StateObject private var expectedResult: ResultSelectionViewModel = ResultSelectionViewModel()
    @StateObject private var simpleInterestResult: SimpleInterestResultViewModel = SimpleInterestResultViewModel(calculationService: CalculationService())
    @StateObject private var simpleInterestRateResult: SimpleInterestRateResultViewModel = SimpleInterestRateResultViewModel(calculationService: CalculationService())
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("What do you need to calculate?")) {
                    ResultSelectionChips(selectedValue: expectedResult)
//                        .listRowBackground(Color.clear)
                }
                switch(expectedResult.selectedResultType) {
                case .simple:
                    SimpleInterestView(result: simpleInterestResult)
                case .simpleInterestRate:
                    SimpleInterestRateView(result: simpleInterestRateResult)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Loans and Savings")
                        .font(.system(size: 18, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
//                ToolbarItemGroup(placement: .keyboard, content: {
//                    Spacer()
//                    Button("Done") {
//                        hideKeyboard()
//                    }.font(.headline)
//                })
            }
        }
    }
}

enum ResultType: String, CaseIterable, Identifiable {
    case simple = "Simple Interest"
    case simpleInterestRate = "Simple Interest Rate"
    
    var id: String {self.rawValue}
}

#Preview {
    LoansAndSavingsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
