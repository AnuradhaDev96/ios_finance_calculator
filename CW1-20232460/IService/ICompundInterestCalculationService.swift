//
//  ICompundInterestCalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//
protocol ICompoundInterestCalculationService {
    func getPeriodInterest(nominamAnnualInterest: Double, noOfCompoundingPeriods: Double) -> Double
    func getNoOfCompoundingsOvertime(compoundingsPerYear: Double, durationInYears: Double) -> Double
}
