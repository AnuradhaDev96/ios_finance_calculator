//
//  TotalCompoundingsOvertimeResultViewModel.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import Foundation

class TotalCompoundingsOvertimeResultViewModel: ObservableObject {
    private let calculationService: ICompoundInterestCalculationService
    
    init(calculationService: ICompoundInterestCalculationService) {
        self.calculationService = calculationService
    }
    
    @Published var noOfCompoundingsOvertime: Double = 0
    @Published var alertDetails = AlertDetails()
    
    private func showMessage(alertKey: String, message: String) {
        alertDetails = AlertDetails(isPresented: true, message: message, alertKey: alertKey)
    }
    
    func calculateCompoundingsOvertime(compoundingsPerYear: String, durationInYears: String) {
        guard let m = Double(compoundingsPerYear),
              let t = Double(durationInYears)
        else {
            showMessage(alertKey: "Invalid input!", message: "Please enter valid numbers.")
            return
        }
        
        noOfCompoundingsOvertime = calculationService.getNoOfCompoundingsOvertime(compoundingsPerYear: m, durationInYears: t)
    }
    
    func resetModel() {
        noOfCompoundingsOvertime = 0
    }
}
