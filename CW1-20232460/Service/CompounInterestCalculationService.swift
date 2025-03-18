//
//  CompounInterestCalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import Foundation

class CompounInterestCalculationService: ICompoundInterestCalculationService {
    func getPresentValue(futureValue: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double {
        futureValue / pow(1 + periodicInterestRate/100, totalCompoundingPeriods)
    }
    
    func getFutureValue(presentValue: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double {
        return presentValue * pow(1 + periodicInterestRate/100, totalCompoundingPeriods)
    }
    
    func getNoOfCompoundingsOvertime(compoundingsPerYear: Double, durationInYears: Double) -> Double {
        return compoundingsPerYear * durationInYears
    }
    
    func getPeriodInterest(nominamAnnualInterest: Double, noOfCompoundingPeriods: Double) -> Double {
        return nominamAnnualInterest / noOfCompoundingPeriods
    }
}
