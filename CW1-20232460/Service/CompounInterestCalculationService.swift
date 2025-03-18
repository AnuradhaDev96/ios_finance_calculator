//
//  CompounInterestCalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import Foundation

class CompounInterestCalculationService: ICompoundInterestCalculationService {
    func getPeriodInterest(nominamAnnualInterest: Double, noOfCompoundingPeriods: Double) -> Double {
        return nominamAnnualInterest / noOfCompoundingPeriods
    }
}
