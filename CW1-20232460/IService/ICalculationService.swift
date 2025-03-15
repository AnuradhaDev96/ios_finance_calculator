//
//  ICalculationService.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import Foundation

protocol ICalculationService {
    func getSimpleInterest(annualInterest: Double, periodInYears: Double, principal: Double) -> Double
}
