//
//  GuidedNumberField.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-18.
//

import SwiftUI

struct GuidedNumberField: View {
    let placeholder: String
    @Binding var text: String
    var suffix: String?
    var guide: AnyView?
    
    var body: some View {
        VStack {
            HStack {
                Text("\(placeholder):")
                    .fontWeight(.regular)
                    .keyboardType(.decimalPad)
                    .onChange(of: text) { oldValue, newValue in
                        text = newValue.filter({"0123456789.".contains($0)})
                    }
                Button {
                    
                } label: {
                    Image(systemName: "info.circle")
                }
                Spacer()
            }
            
            TextField(placeholder, text: $text)
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
}
