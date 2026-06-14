//
//  AppCategory.swift
//  StopBoros
//
//  Created by Bee Wijaya on 12/06/26.
//

import SwiftUI

enum ExpenseCategory: Codable {
    case food, transport, shopping, entertainment
    
    var background: Color {
        switch self {
        case .food:
            return Color("GreenLight")
        case .transport:
            return Color("Transport")
        case .shopping:
            return Color("Shopping")
        case .entertainment:
            return Color("Entertainment")
        }
    }
    
    var icon: String {
        switch self {
        case .food:
            return "fork.knife"
        case .transport:
            return "car.fill"
        case .shopping:
            return "bag.fill"
        case .entertainment:
            return "gamecontroller.fill"
        }
    }
    
    var title: String {
        switch self {
        case .food:
            return "Food"
        case .transport:
            return "Transport"
        case .shopping:
            return "Shopping"
        case .entertainment:
            return "Entertainment"
        }
    }
}

struct Expense: Identifiable {
    var id: UUID = .init()
    var expense: String
    var category: ExpenseCategory
    var created: Date = .now
    var updated: Date = .now
    var amount: Double
}

struct AppExpense: View {
    var expense: ExpenseModel
    
    var formatedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: expense.created)
    }
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: expense.category.icon)
                    .foregroundStyle(expense.category.background)
                    .font(.body)
            }
            .padding()
            .frame(width: 40, height: 40)
            .background(expense.category.background.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.trailing, 6)
            
            
            VStack(alignment: .leading) {
                Text(expense.name)
                    .foregroundStyle(.white)
                    .bold()
                    .font(.title3)
                
                Text("\(expense.category.title) - \(formatedDate)")
                    .foregroundStyle(Color("GrayAsh"))
                    .font(.caption)
            }
            
            Spacer()
            
            Text("- Rp. \(expense.amount.formatted())")
                .foregroundStyle(Color("Alert"))
                .bold()
                .font(.callout)
        }
        .padding(.bottom, 8)
    }
}
