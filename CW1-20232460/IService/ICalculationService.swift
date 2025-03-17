//
//  ICalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import Foundation

protocol ICalculationService {
    func getSimpleInterestFutureValue(annualInterest: Double, periodInYears: Double, principal: Double) -> Double
    func getSimpleInterest(annualInterest: Double, periodInYears: Double, principal: Double) -> Double
    func getSimpleInterestRate(periodInYears: Double, principal: Double, futureValue: Double) -> Double
    func getInvestmentDuration(futureValue: Double, principal: Double, interestRate: Double) -> Double
    func getInitialInvestment(futureValue: Double, periodInYears: Double, interestRate: Double) -> Double
}
