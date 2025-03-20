//
//  CompoundingPeriodType.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-19.
//

enum CompoundingPeriodType: String, CaseIterable, Identifiable {
    case monthly = "Monthly compounding"
    case annual = "Annual Compounding"
    case semiAnnual = "Semi Annual Compounding"
    case daily = "Daily Compunding"
    case quarterly = "Quarterly Compunding"
    case custom = "Custom"
    
    var id: String {self.rawValue}
    
    var compoundingPeriodPerYear: Int {
        switch self {
        case .monthly:
            return 12
        case .annual:
            return 1
        case .semiAnnual:
            return 2
        case .daily:
            return 356
        case .quarterly:
            return 4
        case .custom:
            return 0
        }
    }
    
}
