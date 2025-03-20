//
//  TotalPeriodOfFacilityViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import Foundation

class TotalPeriodOfFacilityResultViewModel: ObservableObject {
    private let calculationService: ICompoundInterestCalculationService
    
    init(calculationService: ICompoundInterestCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var totalPeriodAnswer: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateCompoundingsOvertime(compoundingsPerYear: String, totalCompounds: Double) {
        guard let m = Double(compoundingsPerYear)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        totalPeriodAnswer = calculationService.getPeriodOfFacilityByTotalCompounds(totalCompounds: totalCompounds, noOfCompoundsPerYear: m)
    }
    
    func resetModel() {
        totalPeriodAnswer = 0
    }
}
