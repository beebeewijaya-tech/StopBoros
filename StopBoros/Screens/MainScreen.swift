//
//  MainScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 11/06/26.
//

import SwiftUI
import SwiftData

enum AppTab {
    case home, breakdown, history, wallet, add
}

struct MainScreen: View {
    // MARK: - State
    @State private var selectedTab: AppTab = .home
    @State var isAddExpensePopUp: Bool = false
    @State var isAddWalletPopUp: Bool = false
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
                
                Tab("Wallet", systemImage: "wallet.bifold.fill", value: AppTab.wallet) {
                    WalletScreen()
                }
                
                Tab("", systemImage: "plus", value: AppTab.add, role: .search) {
                    
                }
            }
            .tint(Color("GreenNight"))
            .onChange(of: selectedTab, { oldValue, newValue in
                if newValue == .add {
                    if oldValue == .wallet {
                        // add wallet
                        isAddWalletPopUp.toggle()
                    } else {
                        // add expense
                        isAddExpensePopUp.toggle()
                    }
                    selectedTab = oldValue
                } else {
                    selectedTab = newValue
                }
            })
            .colorScheme(.dark)
            .sheet(isPresented: $isAddExpensePopUp) {
                AddScreen() {
                    isAddExpensePopUp = false
                }
            }
            .sheet(isPresented: $isAddWalletPopUp) {
                AddWalletScreen()
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
