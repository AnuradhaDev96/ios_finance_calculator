//
//  CalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import Foundation

class CalculationService: ICalculationService {
    func getSimpleInterest(annualInterest: Double, periodInYears: Double, principal: Double) -> Double {
        return principal + (1 + annualInterest/100 * periodInYears)
    }
}
