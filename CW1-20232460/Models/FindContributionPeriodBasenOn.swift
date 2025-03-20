//
//  FindContributionsBasenOn.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

enum FindContributionPeriodBasedOn: String, CaseIterable, Identifiable {
    case futureValue = "Future Value"
    case presentValue = "Initial Investment\n(Present Value)"
    
    var id: String {self.rawValue}
}
