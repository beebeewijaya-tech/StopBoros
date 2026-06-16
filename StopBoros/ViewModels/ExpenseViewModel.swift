//
//  ExpenseViewModel.swift
//  StopBoros
//
//  Created by Bee Wijaya on 14/06/26.
//

import SwiftUI
import SwiftData


@Observable
final class ExpenseViewModel {
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    func addExpense(expense: Expense) {
        guard let context = modelContext else { return }
        context.insert(
            ExpenseModel(name: expense.expense, category: expense.category, amount: expense.amount)
        )
        try? context.save()
    }
}
