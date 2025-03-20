//
//  PMTEoPFinContributionsResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import Foundation

class PMTEoPFindContributionsResultViewModel: ObservableObject {
    private let calculationService: IPMTEndOfPeriodCalculationService
    
    init(calculationService: IPMTEndOfPeriodCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var totalContributionsAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    // find n based on FV
    func calculateContributions(payment: String, periodicInterestRate: Double, basedOnValue: String, selectedBasedOnValue: FindContributionPeriodBasedOn) {
        guard let pmt = Double(payment), let b = Double(basedOnValue)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        switch (selectedBasedOnValue) {
        case .futureValue:
            totalContributionsAnswer = calculationService.getNoOfCompoundingsOvertimeBasedOnFutureValue(futureValue: b, periodicInterestRate: periodicInterestRate, payment: pmt)
        case .presentValue:
            totalContributionsAnswer = calculationService.getNoOfCompoundingsOvertimeBasedOnPresentValue(presentValue: b, periodicInterestRate: periodicInterestRate, payment: pmt)
        }
    }
    
    func resetModel() {
        totalContributionsAnswer = 0
    }
}
