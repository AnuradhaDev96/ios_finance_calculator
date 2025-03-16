//
//  ResetButton.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import SwiftUI

struct ResetButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: "arrow.counterclockwise")
                Text("Reset")
            }
            .font(.caption)
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemGray5))
            .clipShape(Capsule())
        }
    }
}
