//
//  MainScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 11/06/26.
//

import SwiftUI
import SwiftData

enum AppTab {
    case home, breakdown, history, profile, add
}

struct MainScreen: View {
    // MARK: - State
    @State private var selectedTab: AppTab = .home
    @State var isAddPopUp: Bool = false
    @State var expenseVM: ExpenseViewModel = ExpenseViewModel()
    
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("AppBackground")
                .ignoresSafeArea(.all)
            
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "house.fill", value: AppTab.home) {
                    HomeScreen()
                }
                
                Tab("Breakdown", systemImage: "chart.pie.fill", value: AppTab.breakdown) {
                    BreakdownScreen()
                }
                
                Tab("History", systemImage: "list.clipboard.fill", value: AppTab.history) {
                    HistoryScreen()
                }
                
                Tab("Profile", systemImage: "person.fill", value: AppTab.profile) {
                    ProfileScreen()
                }
                
                Tab("", systemImage: "plus", value: AppTab.add, role: .search) {
                    
                }
            }
            .tint(Color("GreenNight"))
            .onChange(of: selectedTab, { oldValue, newValue in
                if newValue == .add {
                    selectedTab = oldValue
                    isAddPopUp.toggle()
                } else {
                    selectedTab = newValue
                }
            })
            .colorScheme(.dark)
            .sheet(isPresented: $isAddPopUp) {
                AddScreen() {
                    isAddPopUp = false
                }
            }
        }
        .onAppear {
            expenseVM.modelContext = modelContext
        }
        .environment(expenseVM)
    }
}

#Preview {
    MainScreen()
}
