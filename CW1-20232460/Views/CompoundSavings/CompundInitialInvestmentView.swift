//
//  CompundInitialInvestmentView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import SwiftUI

struct CompundInitialInvestmentView: View {
    @State private var nominalInterestRate: String = ""
    @State var durationInYears: String = ""
    @State var futureValue: String = ""
    @State private var selectedCompundingPeriodType: CompoundingPeriodType = .monthly
    @State private var compoundingPeriodPerYear: String = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
    
    @StateObject private var periodicInterestRateResult: PeriodicInterestResultViewModel
    @StateObject private var totalCompoundingsOvertimeResult: TotalCompoundingsOvertimeResultViewModel
    @StateObject private var result: CompoundInterestPresentValueResultViewModel
    
    init() {
        let calculationService: ICompoundInterestCalculationService = CompounInterestCalculationService()
        _periodicInterestRateResult = StateObject(wrappedValue: PeriodicInterestResultViewModel(calculationService: calculationService))
        _totalCompoundingsOvertimeResult = StateObject(wrappedValue: TotalCompoundingsOvertimeResultViewModel(calculationService: calculationService))
        _result = StateObject(wrappedValue: CompoundInterestPresentValueResultViewModel(calculationService: calculationService))
    }
    
    var isFormInvalid: Bool {
        return nominalInterestRate.isEmpty || durationInYears.isEmpty || futureValue.isEmpty || compoundingPeriodPerYear.isEmpty
    }
    
    var canResetForm: Bool {
        return !nominalInterestRate.isEmpty || !durationInYears.isEmpty || !futureValue.isEmpty
    }
    
    var body: some View {
        Form() {
            Section(header: Text("Compounding Details")) {
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
                    periodicInterestRateResult.calculatePeriodicInterestRate(nominamAnnualInterestRate: nominalInterestRate, noOfCompoundingPeriods: compoundingPeriodPerYear)
                    totalCompoundingsOvertimeResult.calculateCompoundingsOvertime(compoundingsPerYear: compoundingPeriodPerYear, durationInYears: durationInYears)
                }
                
                if (selectedCompundingPeriodType == CompoundingPeriodType.custom) {
                    CustomNumberField(placeholder: "Enter your value", text: $compoundingPeriodPerYear)
                        .onChange(of: compoundingPeriodPerYear) { oldValue, newValue in
                            periodicInterestRateResult.calculatePeriodicInterestRate(nominamAnnualInterestRate: nominalInterestRate, noOfCompoundingPeriods: newValue)
                            totalCompoundingsOvertimeResult.calculateCompoundingsOvertime(compoundingsPerYear: newValue, durationInYears: durationInYears)
                        }
                } else {
                    LabeledContent{
                        Text("\(compoundingPeriodPerYear)")
                    } label: {
                        Text("Selected value:").font(.subheadline)
                    }
                }
            }
            
            Section(header: Text("Interest Rate")) {
                // j
                GuidedNumberField(placeholder: "Nominal Annual Interest Rate", text: $nominalInterestRate, suffix: "%")
                    .onChange(of: nominalInterestRate) { oldValue, newValue in
                        periodicInterestRateResult.calculatePeriodicInterestRate(nominamAnnualInterestRate: newValue, noOfCompoundingPeriods: compoundingPeriodPerYear)
                    }
                
                LabeledContent {
                    Text("\(String(format: "%.2f", periodicInterestRateResult.periodicInterestRate))%")
                } label: {
                    Text("Periodic interest rate:").font(.subheadline)
                }
            }
            
            Section(header: Text("Duration of Loan/Saving")) {
                // t
                GuidedNumberField(placeholder: "Duration", text: $durationInYears, suffix: "years")
                    .onChange(of: durationInYears) { oldValue, newValue in
                        totalCompoundingsOvertimeResult.calculateCompoundingsOvertime(compoundingsPerYear: compoundingPeriodPerYear, durationInYears: newValue)
                    }
                LabeledContent {
                    Text("\(String(format: "%.2f", totalCompoundingsOvertimeResult.noOfCompoundingsOvertime))")
                } label: {
                    Text("Total Compounding Periods:").font(.subheadline)
                }
            }
            
            Section(header: Text("Investment Details")) {
                CustomNumberField(placeholder: "Future Value", text: $futureValue)
            }
            
            VStack {
                Button(action: {
                    hideKeyboard()
                    result.calculateResult(futureValue: futureValue, periodicInterestRate: periodicInterestRateResult.periodicInterestRate, totalCompoundingPeriods: totalCompoundingsOvertimeResult.noOfCompoundingsOvertime)
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
            .listRowBackground(Color.clear)
            
            CompoundInitialValueResultCard(result: result)
        }
        .alert(result.alertDetails.alertKey, isPresented: $result.alertDetails.isPresented) {}
        message: {
            Text(result.alertDetails.message)
        }
    }
    
    private func resetForm() {
        // State properties
        nominalInterestRate = ""
        durationInYears = ""
        futureValue = ""
        selectedCompundingPeriodType = CompoundingPeriodType.monthly
        compoundingPeriodPerYear = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
        
        // View models
        periodicInterestRateResult.resetModel()
        totalCompoundingsOvertimeResult.resetModel()
        result.resetModel()
    }
}

struct CompoundInitialValueResultCard: View {
    @ObservedObject var result: CompoundInterestPresentValueResultViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Present Value")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)

            Text("Rs.\(String(format: "%.2f", result.presentValueAnswer))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
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
