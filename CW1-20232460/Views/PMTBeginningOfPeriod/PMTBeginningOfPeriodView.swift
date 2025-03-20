//
//  DuePaymentsAtBegginingView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-19.
//

import SwiftUI

struct PMTBeginningOfPeriodView: View {
    @State var selectedSideMenuTab: GeneralResultType = .futureValue
    var body: some View {
        VStack {
            Text("Loans/Savings whose Payments are done at BEGINNING of payment period").font(.caption).multilineTextAlignment(.center).fontWeight(.light).foregroundColor(.gray).padding(.horizontal)
            HStack {
                Text(selectedSideMenuTab.props.title).font(.headline).foregroundColor(.gray).padding(.horizontal)
                Spacer()
            }
            TabView(selection: $selectedSideMenuTab) {
                CompoundFutureValueView()
                    .tabItem {
                        Image(systemName: GeneralResultType.futureValue.props.iconName)
                        Text(GeneralResultType.futureValue.props.tabName)
                    }
                    .tag(GeneralResultType.futureValue)
                CompundInitialInvestmentView()
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
        .navigationTitle("Seires of Payments (BoPP")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PMTBeginningOfPeriodView()
}
