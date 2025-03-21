//
//  PeriodicInterestResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import Foundation

class PeriodicInterestResultViewModel: ObservableObject {
    private let calculationService: ICompoundInterestCalculationService
    
    init(calculationService: ICompoundInterestCalculationService) {
        self.calculationService = calculationService
    }
    
    // i = j/m
    @Published var periodicInterestRate: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculatePeriodicInterestRate(nominamAnnualInterestRate: String, noOfCompoundingPeriods: String) {
        guard let j = Double(nominamAnnualInterestRate),
              let m = Double(noOfCompoundingPeriods)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        let i = calculationService.getPeriodInterest(nominamAnnualInterest: j, noOfCompoundingPeriods: m)
        
        periodicInterestRate = i.isInfinite ? 0 : i
    }
    
    func resetModel() {
        periodicInterestRate = 0
    }
}
