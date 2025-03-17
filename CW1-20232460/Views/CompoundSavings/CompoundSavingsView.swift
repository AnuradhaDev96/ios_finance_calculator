//
//  CompoundSavingsView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import SwiftUI

struct CompoundSavingsView: View {
    @State private var showMenu = false

        var body: some View {
            ZStack {
                Button("Toggle Menu") { showMenu.toggle() }
                
                if showMenu {
                    SideMenuView()
                        .transition(.move(edge: .leading))
                }
            }
        }
}

struct SideMenuView: View {
    var body: some View {
        VStack {
            Text("Side Menu")
            Spacer()
        }
        .frame(width: 250)
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    CompoundSavingsView()
}
