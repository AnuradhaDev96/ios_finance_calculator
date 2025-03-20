//
//  PMTEndOfPeriodView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-19.

// Ordinary Annuity Formula
// FVn(ordinary) = PMT * [((1 + i)^n - 1) / i]
// PVn(ordinary) = PMT *[(1 - (1 + i)^-n)/i]

import SwiftUI

struct PMTEndOfPeriodView: View {
    @State var selectedSideMenuTab: GeneralResultType = .futureValue
    
    var body: some View {
        VStack {
            Text("Loans/Savings whose Payments are done at END of payment period").font(.caption).multilineTextAlignment(.center).fontWeight(.light).foregroundColor(.gray).padding(.horizontal)
            HStack {
                Text(selectedSideMenuTab.props.title).font(.headline).foregroundColor(.gray).padding(.horizontal)
                Spacer()
            }
            TabView(selection: $selectedSideMenuTab) {
                PMTEoPFutureValueFormView()
                    .tabItem {
                        Image(systemName: GeneralResultType.futureValue.props.iconName)
                        Text(GeneralResultType.futureValue.props.tabName)
                    }
                    .tag(GeneralResultType.futureValue)
                PMTEoPPresentValueFormView()
                    .tabItem {
                        Image(systemName: GeneralResultType.initialInvestment.props.iconName)
                        Text(GeneralResultType.initialInvestment.props.tabName)
                    }
                    .tag(GeneralResultType.initialInvestment)
                HomeView()
                    .tabItem {
                        Image(systemName: GeneralResultType.contribution.props.iconName)
                        Text(GeneralResultType.contribution.props.tabName)
                    }
                    .tag(GeneralResultType.contribution)
            }
        }
        .navigationTitle("Seires of Payments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PMTEndOfPeriodView()
}
