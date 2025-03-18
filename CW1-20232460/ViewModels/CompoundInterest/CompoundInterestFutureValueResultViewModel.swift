//
//  CompoundInterestFutureValueResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import Foundation

class CompoundInterestFutureValueResultViewModel: ObservableObject {
    private let calculationService: ICompoundInterestCalculationService
    
    init(calculationService: ICompoundInterestCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var futureValueAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateResult(presentValue: String, periodicInterestRate: Double, totalCompoundingPeriods: Double) {
        guard let pv = Double(presentValue)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        futureValueAnswer = calculationService.getFutureValue(presentValue: pv, periodicInterestRate: periodicInterestRate, totalCompoundingPeriods: totalCompoundingPeriods)
    }
    
    func resetModel() {
        futureValueAnswer = 0
    }
}
