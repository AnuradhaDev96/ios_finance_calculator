//
//  InterestResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import Foundation
import SwiftUI

class SimpleInterestResultViewModel: ObservableObject {
    private let calculationService: ICalculationService
    
    init(calculationService: ICalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var isPresented: Bool = false
    @Published var message: String = ""
    @Published var alertKey: String = ""
    
    private func showMessage(alertKey: String, message: String) {
        self.message = message
        self.alertKey = alertKey
        
        isPresented = true
    }
    
    func calculateResult(annualInterest: String, periodInYears: String, principal: String) {
        guard let p = Double(principal),
              let r = Double(annualInterest),
              let t = Double(periodInYears)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            print("cannot convert//ll")
            return
        }
        
        interestAnswer = calculationService.getSimpleInterest(annualInterest: r, periodInYears: t, principal: p)
        futureValueAnswer = calculationService.getSimpleInterestFutureValue(annualInterest: r, periodInYears: t, principal: p)
    }
    
    @Published var interestAnswer: Double = 0
    @Published var futureValueAnswer: Double = 0
    @Published var showFutureValue: Bool = false
    
    func resetModel() {
        interestAnswer = 0
        futureValueAnswer = 0
        showFutureValue = false
    }
}
