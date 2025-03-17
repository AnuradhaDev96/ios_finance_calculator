//
//  ResultSelectionChips.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-14.
//

import SwiftUI

struct ResultSelectionChips: View {
    @ObservedObject var selectedValue: ResultSelectionViewModel
    @State private var showPopover = false
    
    var body: some View {
        Section(
            header: HStack{
                Text("What do you need to calculate?")
                Button(action: {
                    showPopover.toggle()
                }) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.blue)
                }
                .popover(isPresented: $showPopover) {
                    Text("Select the desired output\nyou want to calculate")
                        .font(.body)
                        .textCase(nil)
                        .foregroundColor(.primary)
                        .padding()
                        .presentationCompactAdaptation(.popover)
                }
            }) {
                Picker("I need to find:", selection: $selectedValue.selectedResultType) {
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
}
