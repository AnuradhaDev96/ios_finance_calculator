//
//  CompoundInterestPresentValueResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import Foundation

class CompoundInterestPresentValueResultViewModel: ObservableObject {
    private let calculationService: ICompoundInterestCalculationService
    
    init(calculationService: ICompoundInterestCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var presentValueAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateResult(futureValue: String, periodicInterestRate: Double, totalCompoundingPeriods: Double) {
        guard let fv = Double(futureValue)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        presentValueAnswer = calculationService.getPresentValue(futureValue: fv, periodicInterestRate: periodicInterestRate, totalCompoundingPeriods: totalCompoundingPeriods)
    }
    
    func resetModel() {
        presentValueAnswer = 0
    }
}
