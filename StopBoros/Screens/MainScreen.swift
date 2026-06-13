//
//  MainScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 11/06/26.
//

import SwiftUI

enum AppTab {
    case home, breakdown, history, profile, add
}

struct MainScreen: View {
    @State private var selectedTab: AppTab = .home
    @State private var addPopup: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("AppBackground")
                .ignoresSafeArea(.all)
            
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "house.fill", value: AppTab.home) {
                    HomeScreen()
                }
                
                Tab("Breakdown", systemImage: "chart.pie.fill", value: AppTab.breakdown) {
                    HomeScreen()
                }
                
                Tab("History", systemImage: "list.clipboard.fill", value: AppTab.history) {
                    HomeScreen()
                }
                
                Tab("Profile", systemImage: "person.fill", value: AppTab.profile) {
                    HomeScreen()
                }
                
                Tab("", systemImage: "plus", value: AppTab.add, role: .search) {
                    
                }
            }
            .tint(Color("GreenNight"))
            .onChange(of: selectedTab, { oldValue, newValue in
                if newValue == .add {
                    selectedTab = oldValue
                    addPopup.toggle()
                } else {
                    selectedTab = newValue
                }
            })
            .colorScheme(.dark)
            .sheet(isPresented: $addPopup) {
                AddScreen()
            }
        }
    }
}

#Preview {
    MainScreen()
}
