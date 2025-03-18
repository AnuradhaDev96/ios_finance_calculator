//
//  CompundInitialInvestmentView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import SwiftUI

struct CompundInitialInvestmentView: View {
    @State private var nominalInterestRate: String = ""
    //    @State var isPeriodicInterestRateKnown = true
    @State private var selectedCompundingPeriodType: CompoundingPeriodType = .monthly
    @State private var compoundingPeriodPerYear: String = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
    
    @StateObject private var periodicInterestRateResult: PeriodicInterestResultViewModel
    
    init() {
        let calculationService: ICompoundInterestCalculationService = CompounInterestCalculationService()
        _periodicInterestRateResult = StateObject(wrappedValue: PeriodicInterestResultViewModel(calculationService: calculationService))
    }
    
    var body: some View {
        Form() {
            Section(header: Text("Compounding Information")) {
                // m
                Picker("No. of Compounding Periods Per Year:", selection: $selectedCompundingPeriodType) {
                    ForEach(CompoundingPeriodType.allCases) { type in
                        Text(type.rawValue)
                            .tint(selectedCompundingPeriodType == type ? Color.blue : Color.gray)
                            .controlSize(.large)
                            .multilineTextAlignment(.leading)
                            .buttonStyle(BorderlessButtonStyle())
                            .tag(type)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: selectedCompundingPeriodType) { oldValue, newValue in
                    compoundingPeriodPerYear = "\(newValue.compoundingPeriodPerYear)"
//                    periodicInterestRateResult.calculatePeriodicInterestRate(nominamAnnualInterestRate: nominalInterestRate, noOfCompoundingPeriods: compoundingPeriodPerYear)
                }
                
                if (selectedCompundingPeriodType == CompoundingPeriodType.custom) {
                    CustomNumberField(placeholder: "Enter your value", text: $compoundingPeriodPerYear)
//                        .onChange(of: compoundingPeriodPerYear) { oldValue, newValue in
//                            periodicInterestRateResult.calculatePeriodicInterestRate(nominamAnnualInterestRate: nominalInterestRate, noOfCompoundingPeriods: newValue)
//                        }
                } else {
                    LabeledContent{
                        Text("\(compoundingPeriodPerYear)")
                    } label: {
                        Text("Selected value:").font(.subheadline)
                    }
                }
                // i
                //                Toggle("Do you know Periodic interest rate?", isOn: $isPeriodicInterestRateKnown).padding(.top, 10)
            }
            
            Section(header: Text("Interest Rate")) {
                // j
                GuidedNumberField(placeholder: "Nominal Annual Interest Rate", text: $nominalInterestRate, suffix: "%")
//                    .onChange(of: nominalInterestRate) { oldValue, newValue in
//                        periodicInterestRateResult.calculatePeriodicInterestRate(nominamAnnualInterestRate: newValue, noOfCompoundingPeriods: newValue)
//                    }
                
                LabeledContent {
                    Text("\(String(format: "%.2f", periodicInterestRateResult.periodicInterestRate))%")
                } label: {
                    Text("Periodic interest rate:").font(.subheadline)
                }
            }
        }
    }
}

enum CompoundingPeriodType: String, CaseIterable, Identifiable {
    case monthly = "Monthly compounding"
    case annual = "Annual Compounding"
    case semiAnnual = "Semi Annual Compounding"
    case daily = "Daily Compunding"
    case quarterly = "Quarterly Compunding"
    case custom = "Custom"
    
    var id: String {self.rawValue}
    
    var compoundingPeriodPerYear: Int {
        switch self {
        case .monthly:
            return 12
        case .annual:
            return 1
        case .semiAnnual:
            return 2
        case .daily:
            return 356
        case .quarterly:
            return 4
        case .custom:
            return 0
        }
    }
    
}

#Preview {
    CompundInitialInvestmentView()
}
