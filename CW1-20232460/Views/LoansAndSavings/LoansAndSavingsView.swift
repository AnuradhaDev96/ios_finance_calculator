//
//  LoansAndSavingsView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-13.
//

import SwiftUI

struct LoansAndSavingsView: View {
    @StateObject private var expectedResult: ResultSelectionViewModel = ResultSelectionViewModel()
    @StateObject private var simpleInterestResult: SimpleInterestResultViewModel
    @StateObject private var simpleInterestRateResult: SimpleInterestRateResultViewModel
    @StateObject private var investmentDurationResult: SimpleInterestInvestmentDurationResultViewModel
    @StateObject private var initialInvestmentResult: SimpleInterestPrincipalResultViewModel
    
    init() {
        let calculationService: ICalculationService = CalculationService()
        _simpleInterestResult = StateObject(wrappedValue: SimpleInterestResultViewModel(calculationService: calculationService))
        _simpleInterestRateResult = StateObject(wrappedValue: SimpleInterestRateResultViewModel(calculationService: calculationService))
        _investmentDurationResult = StateObject(wrappedValue: SimpleInterestInvestmentDurationResultViewModel(calculationService: calculationService))
        _initialInvestmentResult = StateObject(wrappedValue: SimpleInterestPrincipalResultViewModel(calculationService: calculationService))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("What do you need to calculate?")) {
                    ResultSelectionChips(selectedValue: expectedResult)
                }
                switch(expectedResult.selectedResultType) {
                case .simple:
                    SimpleInterestView(result: simpleInterestResult)
                case .simpleInterestRate:
                    SimpleInterestRateView(result: simpleInterestRateResult)
                case .investmentDuration:
                    InvestmentDurationView(result: investmentDurationResult)
                case .initialInvestment:
                    InitialInvestmentView(result: initialInvestmentResult)
                }
                Section(header: Text("Answer")) {
                    switch(expectedResult.selectedResultType) {
                    case .simple:
                        SimpleInterestResultCard(result: simpleInterestResult)
                    case .simpleInterestRate:
                        SimpleInterestRateResultCard(result: simpleInterestRateResult)
                    case .investmentDuration:
                        InvestmentDurationResultCard(result: investmentDurationResult)
                    case .initialInvestment:
                        InitialInvestmentResultCard(result: initialInvestmentResult)
                    }
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
    case investmentDuration = "Investment Duration"
    case initialInvestment = "Initial Investment\n(Principal Amount)"
    
    var id: String {self.rawValue}
}

#Preview {
    LoansAndSavingsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
