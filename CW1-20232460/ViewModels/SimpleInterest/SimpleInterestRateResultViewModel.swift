//
//  SimpleInterestRateResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-16.
//

import Foundation


class SimpleInterestRateResultViewModel: ObservableObject {
    private let calculationService: ISimpleInteresCalculationService
    
    init(calculationService: ISimpleInteresCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var interestRateAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateResult(futureValue: String, periodInYears: String, principal: String) {
        guard let p = Double(principal),
              let f = Double(futureValue),
              let t = Double(periodInYears)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        interestRateAnswer = calculationService.getSimpleInterestRate(periodInYears: t, principal: p, futureValue: f)
    }
    
    func resetModel() {
        interestRateAnswer = 0
    }
}
