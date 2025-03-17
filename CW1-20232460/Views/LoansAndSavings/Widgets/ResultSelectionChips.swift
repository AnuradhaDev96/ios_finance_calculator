//
//  ResultSelectionChips.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-14.
//

import SwiftUI

struct ResultSelectionChips: View {
    @ObservedObject var selectedValue: ResultSelectionViewModel
    
    var body: some View {
        Picker("I need to calculate:", selection: $selectedValue.selectedResultType) {
            ForEach(ResultType.allCases) { type in
                Text(type.rawValue)
                    .tint(selectedValue.selectedResultType == type ? Color.blue : Color.gray)
                    .controlSize(.large)
                    .multilineTextAlignment(.leading)
                    .buttonStyle(BorderlessButtonStyle())
                    .tag(type)
            }
        }.pickerStyle(.menu)
    }
}
