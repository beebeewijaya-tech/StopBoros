//
//  ExpenseModel.swift
//  StopBoros
//
//  Created by Bee Wijaya on 14/06/26.
//

import SwiftUI
import SwiftData

@Model
class ExpenseModel {
    var name: String
    var category: ExpenseCategory
    var amount: Double
    var created: Date
    var updated: Date
    
    init(name: String, category: ExpenseCategory, amount: Double) {
        self.name = name
        self.category = category
        self.amount = amount
        self.created = .now
        self.updated = .now
    }
}
