//
//  PMTEoPFutureValueFormView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import SwiftUI

struct PMTEoPFutureValueFormView: View {
    @State private var nominalInterestRate: String = ""
    @State var durationInYears: String = ""
    @State var paymentValue: String = ""
    @State private var selectedCompundingPeriodType: CompoundingPeriodType = .monthly
    @State private var compoundingPeriodPerYear: String = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
    
    @StateObject private var periodicInterestRateResult: PeriodicInterestResultViewModel
    @StateObject private var totalCompoundingsOvertimeResult: TotalCompoundingsOfGivenPeriodResultViewModel
    @StateObject private var result: PMTEoPFutureValueResultViewModel
    
    init() {
        let calculationService: ICompoundInterestCalculationService = CompounInterestCalculationService()
        let pmtCalculationService: IPMTEndOfPeriodCalculationService = PMTEndOfPeriodCalculationService()
        _periodicInterestRateResult = StateObject(wrappedValue: PeriodicInterestResultViewModel(calculationService: calculationService))
        _totalCompoundingsOvertimeResult = StateObject(wrappedValue: TotalCompoundingsOfGivenPeriodResultViewModel(calculationService: calculationService))
        _result = StateObject(wrappedValue: PMTEoPFutureValueResultViewModel(calculationService: pmtCalculationService))
    }
    
    private var isFormInvalid: Bool {
        return nominalInterestRate.isEmpty || durationInYears.isEmpty || paymentValue.isEmpty || compoundingPeriodPerYear.isEmpty
    }
    
    private var canResetForm: Bool {
        return !nominalInterestRate.isEmpty || !durationInYears.isEmpty || !paymentValue.isEmpty
    }
    
    private func resetForm() {
        // State properties
        nominalInterestRate = ""
        durationInYears = ""
        paymentValue = ""
        selectedCompundingPeriodType = CompoundingPeriodType.monthly
        compoundingPeriodPerYear = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
        
        // View models
        periodicInterestRateResult.resetModel()
        totalCompoundingsOvertimeResult.resetModel()
        result.resetModel()
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
                    Text("\(String(format: "%.2f", totalCompoundingsOvertimeResult.noOfCompoundingsForPeriod))")
                } label: {
                    Text("Total Compounding Periods:").font(.subheadline)
                }
            }
            
            Section(header: Text("Payment Series Details")) {
                CustomNumberField(placeholder: "Payment Installment", text: $paymentValue)
            }
            
            VStack {
                Button(action: {
                    hideKeyboard()
                    result.calculateResult(payment: paymentValue, periodicInterestRate: periodicInterestRateResult.periodicInterestRate, totalCompoundingPeriods: totalCompoundingsOvertimeResult.noOfCompoundingsForPeriod)
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
            
            PMTEoPFutureValueResultCard(result: result)
        }
        .alert(result.alertDetails.alertKey, isPresented: $result.alertDetails.isPresented) {}
        message: {
            Text(result.alertDetails.message)
        }
    }
}

struct PMTEoPFutureValueResultCard: View {
    @ObservedObject var result: PMTEoPFutureValueResultViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Future Value")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)

            Text("Rs.\(String(format: "%.2f", result.futureValueAnswer))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}


#Preview {
    PMTEoPFutureValueFormView()
}
