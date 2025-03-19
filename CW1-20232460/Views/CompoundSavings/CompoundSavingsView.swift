//
//  CompoundSavingsView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import SwiftUI

struct CompoundSavingsView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab:SideMenuRowType = .interestRate
    
    var body: some View {
        ZStack{
            if (!presentSideMenu) {
                VStack {
                    HStack {
                        Text(selectedSideMenuTab.props.title).font(.headline).foregroundColor(.gray).padding()
                        Spacer()
                    }
                    TabView(selection: $selectedSideMenuTab) {
                        HomeView()
                            .tabItem {
                                Image(systemName: SideMenuRowType.interestRate.props.iconName)
                                Text(SideMenuRowType.interestRate.props.tabName)
                            }
                            .tag(SideMenuRowType.interestRate)
                        CompoundFutureValueView()
                            .tabItem {
                                Image(systemName: SideMenuRowType.futureValue.props.iconName)
                                Text(SideMenuRowType.futureValue.props.tabName)
                            }
                            .tag(SideMenuRowType.futureValue)
                        CompundInitialInvestmentView()
                            .tabItem {
                                Image(systemName: SideMenuRowType.initialInvestment.props.iconName)
                                Text(SideMenuRowType.initialInvestment.props.tabName)
                            }
                            .tag(SideMenuRowType.initialInvestment)
                        HomeView()
                            .tabItem {
                                Image(systemName: SideMenuRowType.contribution.props.iconName)
                                Text(SideMenuRowType.contribution.props.tabName)
                            }
                            .tag(SideMenuRowType.contribution)
                    }
                    .navigationTitle("Compound Interest")
                    .navigationBarTitleDisplayMode(.inline)
//                    .toolbarBackground(.bar, for: .navigationBar)
                    .toolbarBackground(Color.white, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button{
                                presentSideMenu.toggle()
                            } label: {
                                HStack(spacing: 2) {
                                    Text("Toggle")
                                        .font(.caption)
                                    Image(systemName: "square.stack.3d.forward.dottedline.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 22, height: 22)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            
            SideDrawer(isShowing: $presentSideMenu, content: AnyView(DrawerContent(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct HomeView: View {
    
    var body: some View {
        VStack{
            Text("Home View")
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

struct SideDrawer: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

struct DrawerContent: View {
    
    @Binding var selectedSideMenuTab: SideMenuRowType
    @Binding var presentSideMenu: Bool
    
    private let width = UIScreen.main.bounds.width - 100
    
    var body: some View {
        HStack {
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: width)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
//                    Spacer()
                    Text("Toggle Outcome (Result)").font(.title).bold().padding()
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row, imageName: row.props.iconName, title: row.props.title) {
                            selectedSideMenuTab = row
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: width)
                .background(
                    Color.white
                )
            }
            
            Spacer()
        }
        .background(.clear)
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .blue : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .blue.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}

enum SideMenuRowType: Int, CaseIterable, Identifiable {
    case interestRate = 0
    case futureValue
    case initialInvestment
    case contribution
    
    var props: (title: String, iconName: String, tabName: String){
        switch self {
        case .interestRate:
            return ("Find interest rate", "percent", "Rate")
        case .futureValue:
            return ("Find future value", "hands.sparkles", "Future Value")
        case .initialInvestment:
            return ("Find initial investment", "door.left.hand.open", "Initial Value")
        case .contribution:
            return ("Find no. of contributions", "infinity.circle", "Contriobutions")
        }
    }
    
    var id: Int {self.rawValue}
}
#Preview {
    CompoundSavingsView()
}
