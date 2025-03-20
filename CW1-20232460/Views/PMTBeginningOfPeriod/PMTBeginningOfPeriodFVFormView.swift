//
//  DuePaymentFindFutureValueFormView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-19.
//

import SwiftUI

struct PMTBeginningOfPeriodFVFormView: View {
    @State private var nominalInterestRate: String = ""
    @State var durationInYears: String = ""
    @State var presentValue: String = ""
    @State var paymentValue: String = ""
    @State private var selectedCompundingPeriodType: CompoundingPeriodType = .monthly
    @State private var compoundingPeriodPerYear: String = "\(CompoundingPeriodType.monthly.compoundingPeriodPerYear)"
    
    @StateObject private var periodicInterestRateResult: PeriodicInterestResultViewModel
    @StateObject private var totalCompoundingsOvertimeResult: TotalCompoundingsOfGivenPeriodResultViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
