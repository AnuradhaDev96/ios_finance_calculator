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
    var suffix: String?
    
    var body: some View {
        LabeledContent{
            TextField(placeholder, text: $text)
                .keyboardType(.decimalPad)
        } label: {
            Text("\(placeholder):").font(.subheadline)
        }
        .overlay(            
            HStack {
                if let suffix = suffix {
                    Spacer()
                    Text(suffix)
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
            
        )
    }
}
