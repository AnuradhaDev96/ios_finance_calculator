//
//  PMTEoPFindContributionsFormView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

// From FV
// n = ln((Fv *i)/PMT) + 1) / ln(1 + i)

import SwiftUI

struct PMTEoPFindContributionsFormView: View {
    @State private var nominalInterestRate: String = ""
    @State var basedOnValue: String = ""
    @State var paymentValue: String = ""
    @State private var selectedCompundingPeriodType: CompoundingPeriodType = .monthly
    @State private var compoundingPeriodPerYear: String = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
    @State private var selectedBasedOnType = FindContributionPeriodBasedOn.futureValue
    
    @StateObject private var periodicInterestRateResult: PeriodicInterestResultViewModel
    @StateObject private var periodOfFacilityResult: TotalPeriodOfFacilityResultViewModel
    
    @StateObject private var result: PMTEoPFindContributionsResultViewModel
    
    init() {
        let calculationService: ICompoundInterestCalculationService = CompoundInterestCalculationService()
        let pmtCalculationService: IPMTEndOfPeriodCalculationService = PMTEndOfPeriodCalculationService()
        
        _periodicInterestRateResult = StateObject(wrappedValue: PeriodicInterestResultViewModel(calculationService: calculationService))
        _periodOfFacilityResult = StateObject(wrappedValue: TotalPeriodOfFacilityResultViewModel(calculationService: calculationService))
        _result = StateObject(wrappedValue: PMTEoPFindContributionsResultViewModel(calculationService: pmtCalculationService))
    }
    
    private var isFormInvalid: Bool {
        return basedOnValue.isEmpty || paymentValue.isEmpty || compoundingPeriodPerYear.isEmpty
    }
    
    private var canResetForm: Bool {
        return !basedOnValue.isEmpty || !paymentValue.isEmpty
    }
    
    private func resetForm() {
        // State properties
        nominalInterestRate = ""
        basedOnValue = ""
        paymentValue = ""
        selectedCompundingPeriodType = CompoundingPeriodType.monthly
        compoundingPeriodPerYear = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
        
        // View models
        periodicInterestRateResult.resetModel()
        periodOfFacilityResult.resetModel()
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
                }
                
                if (selectedCompundingPeriodType == CompoundingPeriodType.custom) {
                    CustomNumberField(placeholder: "Enter your value", text: $compoundingPeriodPerYear)
                        .onChange(of: compoundingPeriodPerYear) { oldValue, newValue in
                            periodicInterestRateResult.calculatePeriodicInterestRate(nominamAnnualInterestRate: nominalInterestRate, noOfCompoundingPeriods: newValue)
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
            
            Section(header: Text("Find no. of contributions based on *")) {
                // m
                Picker("Select value type", selection: $selectedBasedOnType) {
                    ForEach(FindContributionPeriodBasedOn.allCases) { type in
                        Text(type.rawValue)
                            .tint(selectedBasedOnType == type ? Color.blue : Color.gray)
                            .controlSize(.large)
                            .multilineTextAlignment(.leading)
                            .buttonStyle(BorderlessButtonStyle())
                            .tag(type)
                    }
                }
                .pickerStyle(.menu)
                
                CustomNumberField(placeholder: "Enter your value", text: $basedOnValue)
            }
            
            Section(header: Text("Payment Series Details")) {
                CustomNumberField(placeholder: "Payment Installment", text: $paymentValue)
            }
            
            VStack {
                Button(action: {
                    hideKeyboard()
                    result.calculateContributions(payment: paymentValue, periodicInterestRate: periodicInterestRateResult.periodicInterestRate, basedOnValue: basedOnValue, selectedBasedOnValue: selectedBasedOnType)
                    periodOfFacilityResult.calculateCompoundingsOvertime(compoundingsPerYear: compoundingPeriodPerYear, totalCompounds: result.totalContributionsAnswer)
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
            
            PMTEoPContributionPeriodResultCard(result: result, yearsResult: periodOfFacilityResult)
        }
        .alert(result.alertDetails.alertKey, isPresented: $result.alertDetails.isPresented) {}
        message: {
            Text(result.alertDetails.message)
        }
    }
    
}

struct PMTEoPContributionPeriodResultCard: View {
    @ObservedObject var result: PMTEoPFindContributionsResultViewModel
    @ObservedObject var yearsResult: TotalPeriodOfFacilityResultViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("Total contribution periods")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("\(String(format: "%.2f", result.totalContributionsAnswer))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            VStack(alignment: .center, spacing: 2) {
                Spacer()
                Text("Period of this Facility")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("\(String(format: "%.2f", yearsResult.totalPeriodAnswer)) years")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    PMTEoPFindContributionsFormView()
}
