//
//  ContentView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let gridItems = [GridItem(.adaptive(minimum: 150), spacing: 16), GridItem(.adaptive(minimum: 150), spacing: 16)]
    let gridTiles = [
        TileItem(iconName: "dollarsign.arrow.circlepath", title: "Loans & Savings",subtitle: "with Compound Interest", destination: {AnyView(CompoundSavingsView())}),
        TileItem(iconName: "dollarsign.bank.building", title: "Loans & Savings",subtitle: "with Simple Interest", destination: {AnyView(LoansAndSavingsView())}),
        TileItem(iconName: "dollarsign.circle", title: "Mortgage", destination: {AnyView(MortgageView())}),
        TileItem(iconName: "rectangle.stack.badge.play", title: "Seires of Payments", subtitle: "Payments for loans done at BEGINNING of payment period", destination: {AnyView(PMTBeginningOfPeriodView())}),
        TileItem(iconName: "pawprint", title: "Seires of Payments", subtitle: "Payments for loans done at END of payment period", destination: {AnyView(PMTEndOfPeriodView())}),
        TileItem(iconName: "questionmark.circle", title: "Help", destination: {AnyView(HelpView())}),
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
//                Text("Financial Calculator")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: gridItems, spacing: 12) {
                    ForEach(gridTiles) { tile in
                        TileView(tile: tile)
                    }
                }
                .padding()
            }
            .navigationTitle("Financial Calculator")
            .frame(maxWidth: .infinity, alignment: .top) // Align to start of the screen
            .padding(.top, 50)
        }
    }
}


struct TileView: View {
    let tile: TileItem
    
    var body: some View {
        NavigationLink(destination: tile.destination) {
            VStack {
                Image(systemName: tile.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                Text(tile.title)
                    .font(.headline)
                
                if let subtitle = tile.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 180, height: 160)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

struct TileItem : Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let subtitle: String?
    let destination: () -> AnyView
    
    init(iconName: String, title: String, subtitle: String? = nil, destination: @escaping () -> AnyView) {
        self.iconName = iconName
        self.title = title
        self.destination = destination
        self.subtitle = subtitle
    }
}
