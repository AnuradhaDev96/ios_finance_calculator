//
//  PMTEndOfPeriodCalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import Foundation

class PMTEndOfPeriodCalculationService: IPMTEndOfPeriodCalculationService {
    // PVn(ordinary) = PMT *[(1 - (1 + i)^-n)/i]
    func getPresentValue(payment: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double {
        let accumulationFactor = (1 - pow((1 + periodicInterestRate/100), -totalCompoundingPeriods)) / (periodicInterestRate/100)
        
        return payment * accumulationFactor
    }
    
    
    // FVn(ordinary) = PMT * [((1 + i)^n - 1) / i]
    func getFutureValue(payment: Double, periodicInterestRate: Double, totalCompoundingPeriods: Double) -> Double {
        let accumulationFactor = (pow((1 + periodicInterestRate/100), totalCompoundingPeriods) - 1) / (periodicInterestRate/100)
        
        return payment * accumulationFactor
    }
}
