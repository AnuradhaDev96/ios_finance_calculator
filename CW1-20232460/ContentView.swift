//
//  ContentView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    let gridTiles = [
        TileItem(iconName: "dollarsign.arrow.circlepath", title: "Interests", destination: {AnyView(LoansAndSavingsView())}),
        TileItem(iconName: "dollarsign.bank.building", title: "Loans & Savings", destination: {AnyView(LoansAndSavingsView())}),
        TileItem(iconName: "dollarsign.circle", title: "Mortgage", destination: {AnyView(LoansAndSavingsView())}),
        TileItem(iconName: "questionmark.circle", title: "Help", destination: {AnyView(LoansAndSavingsView())}),
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Text("Financial Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(gridTiles) { tile in
                        TileView(tile: tile)
                    }
                }
                .padding()
            }
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
            }
            .frame(width: 150, height: 100)
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
    let destination: () -> AnyView
    
    init(iconName: String, title: String, destination: @escaping () -> AnyView) {
        self.iconName = iconName
        self.title = title
        self.destination = destination
    }
}
