//
//  HelpView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-20.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack {
            Text("Designed & Developed by").font(.caption).fontWeight(.light)
            Text("Anuradha Siribaddana").font(.title).bold()
            Text("20232460").font(.subheadline).bold()
        }
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    HelpView()
}
