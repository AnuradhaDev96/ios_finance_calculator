//
//  SimpleInterestRateResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-16.
//

import Foundation


class SimpleInterestRateResultViewModel: ObservableObject {
    private let calculationService: ICalculationService
    
    init(calculationService: ICalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var interestRateAnswer: Double = 0
    
    func calculateResult(futureValue: String, periodInYears: String, principal: String) {
        guard let p = Double(principal),
              let f = Double(futureValue),
              let t = Double(periodInYears) else { return }
        
        interestRateAnswer = calculationService.getSimpleInterestRate(periodInYears: t, principal: p, futureValue: f)
    }
    
    func resetModel() {
        interestRateAnswer = 0
    }
}
