//
//  IPMTEndOfPeriodCalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import Foundation

protocol IPMTEndOfPeriodCalculationService {
//    func getPeriodInterest(nominamAnnualInterest: Double, noOfCompoundingPeriods: Double) -> Double
//    func getNoOfCompoundingsOvertime(compoundingsPerYear: Double, durationInYears: Double) -> Double
    func getFutureValue(payment: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double
    func getPresentValue(payment: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double
}
