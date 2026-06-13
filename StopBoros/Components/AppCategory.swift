//
//  AppCategory.swift
//  StopBoros
//
//  Created by Bee Wijaya on 12/06/26.
//

import SwiftUI

struct Category: Identifiable {
    var id: UUID = .init()
    var category: String
    var style: ExpenseCategory
}

struct AppCategory: View {
    var category: Category
    var active: Bool
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: category.style.icon)
                    .foregroundStyle(category.style.background)
                    .font(.body)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.trailing, 2)
            
            VStack(alignment: .leading) {
                Text(category.category)
                    .foregroundStyle(active ? category.style.background : .white)
                    .bold()
                    .font(.callout)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(category.style.background.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(active ? category.style.background : .clear, lineWidth: 2)
        )
        .padding(.bottom, 8)
    }
}
