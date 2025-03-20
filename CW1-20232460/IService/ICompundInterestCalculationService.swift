//
//  ICompundInterestCalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//
protocol ICompoundInterestCalculationService {
    func getPeriodInterest(nominamAnnualInterest: Double, noOfCompoundingPeriods: Double) -> Double
    func getNoOfCompoundingsOvertime(compoundingsPerYear: Double, durationInYears: Double) -> Double
    func getPeriodOfFacilityByTotalCompounds(totalCompounds: Double, noOfCompoundsPerYear: Double) -> Double
    func getFutureValue(presentValue: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double
    func getPresentValue(futureValue: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double
}
