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
    var expenses: [ExpenseModel] = []
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    func fetchExpenses() {
        guard let context = modelContext else { return }
        let descriptor = FetchDescriptor<ExpenseModel>(
            sortBy: [SortDescriptor(\.created, order: .reverse)]
        )
        
        expenses = (try? context.fetch(descriptor)) ?? []
    }
    
    func addExpense(expense: Expense) {
        guard let context = modelContext else { return }
        context.insert(
            ExpenseModel(name: expense.expense, category: expense.category, amount: expense.amount)
        )
        try? context.save()
    }
}
