//
//  StopBorosApp.swift
//  StopBoros
//
//  Created by Bee Wijaya on 11/06/26.
//

import SwiftUI
import SwiftData

@main
struct StopBorosApp: App {
    let expenseContainer = try! ModelContainer(for: ExpenseModel.self, WalletModel.self)
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .modelContainer(expenseContainer)
        }
    }
}
