//
//  GeneralResultType.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-19.
//

import Foundation

enum GeneralResultType: Int, CaseIterable, Identifiable {
    case futureValue = 0
    case initialInvestment
    case contribution
    
    var props: (title: String, iconName: String, tabName: String, description: String){
        switch self {
        case .futureValue:
            return ("Find future value", "hands.sparkles", "Future Value", "How much I earn/spent at end?")
        case .initialInvestment:
            return ("Find initial investment", "door.left.hand.open", "Initial Value", "How much should I invest to reach this amount?")
        case .contribution:
            return ("Find no. of contributions", "infinity.circle", "Contriobutions", "How long will it take to repay or get full amount?")
        }
    }
    
    var id: Int {self.rawValue}
}
