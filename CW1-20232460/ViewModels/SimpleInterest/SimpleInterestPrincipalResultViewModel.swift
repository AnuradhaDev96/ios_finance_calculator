//
//  SimpleInterestPrincipalResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import Foundation

class SimpleInterestPrincipalResultViewModel: ObservableObject {
    private let calculationService: ISimpleInteresCalculationService
    
    init(calculationService: ISimpleInteresCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var initialInvestmentAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateResult(futureValue: String, interestRate: String, durationInYears: String) {
        guard let t = Double(durationInYears),
              let f = Double(futureValue),
              let r = Double(interestRate)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        initialInvestmentAnswer = calculationService.getInitialInvestment(futureValue: f, periodInYears: t, interestRate: r)
    }
    
    func resetModel() {
        initialInvestmentAnswer = 0
    }
}
