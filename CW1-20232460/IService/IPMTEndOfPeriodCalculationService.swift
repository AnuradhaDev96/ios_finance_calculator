//
//  IPMTEndOfPeriodCalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import Foundation

protocol IPMTEndOfPeriodCalculationService {
//    func getPeriodInterest(nominamAnnualInterest: Double, noOfCompoundingPeriods: Double) -> Double
    
    // n = ln((Fv *i)/PMT) + 1) / ln(1 + i)
    func getNoOfCompoundingsOvertimeBasedOnFutureValue(futureValue: Double, periodicInterestRate: Double, payment: Double) -> Double
    
    // n = (-ln(1 - (Pv * i / PMT)) / ln (1 + i)
    func getNoOfCompoundingsOvertimeBasedOnPresentValue(presentValue: Double, periodicInterestRate: Double, payment: Double) -> Double
    
    func getFutureValue(payment: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double
    func getPresentValue(payment: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double
}
