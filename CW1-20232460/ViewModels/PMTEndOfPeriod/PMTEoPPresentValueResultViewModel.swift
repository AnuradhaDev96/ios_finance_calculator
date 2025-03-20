//
//  PMTEoPPresentValueResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import Foundation

class PMTEoPPresentValueResultViewModel: ObservableObject {
    private let calculationService: IPMTEndOfPeriodCalculationService
    
    init(calculationService: IPMTEndOfPeriodCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var presentValueAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateResult(payment: String, periodicInterestRate: Double, totalCompoundingPeriods: Double) {
        guard let pmt = Double(payment)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        presentValueAnswer = calculationService.getPresentValue(payment: pmt, periodicInterestRate: periodicInterestRate, totalCompoundingPeriods: totalCompoundingPeriods)
    }
    
    func resetModel() {
        presentValueAnswer = 0
    }
}
