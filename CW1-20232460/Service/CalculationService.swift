//
//  CalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import Foundation

class CalculationService: ICalculationService {
    func getInitialInvestment(futureValue: Double, periodInYears: Double, interestRate: Double) -> Double {
        return 0
    }
    
    func getSimpleInterestRate(periodInYears: Double, principal: Double, futureValue: Double) -> Double {
        let upper = futureValue - principal
        let lower = principal * periodInYears
        return (upper / lower) * 100
    }
    
    func getSimpleInterest(annualInterest: Double, periodInYears: Double, principal: Double) -> Double {
        return principal * annualInterest/100 * periodInYears
    }
    
    func getSimpleInterestFutureValue(annualInterest: Double, periodInYears: Double, principal: Double) -> Double {
        return principal * (1 + annualInterest/100 * periodInYears)
    }
    
    func getInvestmentDuration(futureValue: Double, principal: Double, interestRate: Double) -> Double {
        let upper = futureValue - principal
        let lower = principal * interestRate/100
        
        return upper/lower
    }
}
