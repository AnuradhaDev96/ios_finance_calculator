//
//  CustomNumberField.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-14.
//

import SwiftUI

struct CustomNumberField: View {
    let placeholder: String
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool

    var body: some View {
        LabeledContent{
            TextField(placeholder, text: $text)
                .keyboardType(.decimalPad).focused($isFocused)
        } label: {
            Text("\(placeholder):").font(.subheadline)
        }
//        VStack(alignment: .leading, spacing: 4) {
//            Text(placeholder) // Label
//                    .font(.caption)
//            
//            TextField(placeholder, text: $text)
//                .keyboardType(.decimalPad)
//        }
    }
}
