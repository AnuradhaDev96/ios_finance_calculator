//
//  ResultContainer.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-15.
//

import SwiftUI

struct ResultContainer: View {
    let title: String
    
    @ObservedObject var result: InterestResultViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Text("Rs.\(String(format: "%.2f", result.interestAnswer))")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            if (result.showFutureValue) {
                VStack(alignment: .center, spacing: 2) {
                    Spacer()
                    Text("Future Value")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Rs.\(String(format: "%.2f", result.futureValueAnswer))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
