//
//  SimpleInterestInvestmentDurationViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import Foundation

class SimpleInterestInvestmentDurationResultViewModel: ObservableObject {
    private let calculationService: ISimpleInteresCalculationService
    
    init(calculationService: ISimpleInteresCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var investmentDurationAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateResult(futureValue: String, interestRate: String, principal: String) {
        guard let p = Double(principal),
              let f = Double(futureValue),
              let r = Double(interestRate)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        investmentDurationAnswer = calculationService.getInvestmentDuration(futureValue: f, principal: p, interestRate: r)
    }
    
    func resetModel() {
        investmentDurationAnswer = 0
    }
}
