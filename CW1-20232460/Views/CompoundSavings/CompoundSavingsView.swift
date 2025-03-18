//
//  CompoundSavingsView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-17.
//

import SwiftUI

struct CompoundSavingsView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab:SideMenuRowType = .home
    
    var body: some View {
        ZStack{
            if (!presentSideMenu) {
                TabView(selection: $selectedSideMenuTab) {
                    HomeView(presentSideMenu: $presentSideMenu)
                        .tag(0)
                    HomeView(presentSideMenu: $presentSideMenu)
                        .tag(1)
                    HomeView(presentSideMenu: $presentSideMenu)
                        .tag(2)
                    HomeView(presentSideMenu: $presentSideMenu)
                        .tag(3)
                }
                .navigationTitle("Compoundings")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { // Right-side icon
                        Button{
                            presentSideMenu.toggle()
                        } label: {
                            HStack {
                                Text("Switch Result")
                                    .font(.subheadline)
                                Image(systemName: "square.stack.3d.forward.dottedline.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.blue)
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
    
    @Binding var presentSideMenu: Bool
    
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
                    Spacer()
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
                        Image(imageName)
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

enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case favorite
    case chat
    case profile
    
    var props: (title: String, iconName: String){
        switch self {
        case .home:
            return ("Find interest rate", "home")
        case .favorite:
            return ("Find future value", "favorite")
        case .chat:
            return ("Find initial investment", "chat")
        case .profile:
            return ("Find monthly contribution", "profile")
        }
    }
}
#Preview {
    CompoundSavingsView()
}
