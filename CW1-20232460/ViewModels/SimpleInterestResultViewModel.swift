//
//  InterestResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import Foundation

class SimpleInterestResultViewModel: ObservableObject {
    private let calculationService: ICalculationService
    
    init(calculationService: ICalculationService) {
        self.calculationService = calculationService
    }
    
    func calculateResult(annualInterest: String, periodInYears: String, principal: String) {
        guard let p = Double(principal),
              let r = Double(annualInterest),
              let t = Double(periodInYears) else { return }
        
        interestAnswer = calculationService.getSimpleInterest(annualInterest: r, periodInYears: t, principal: p)
        futureValueAnswer = calculationService.getSimpleInterestFutureValue(annualInterest: r, periodInYears: t, principal: p)
    }
    
    @Published var interestAnswer: Double = 0
    @Published var futureValueAnswer: Double = 0
    @Published var showFutureValue: Bool = false
}
