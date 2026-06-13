//
//  AddScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 13/06/26.
//

import SwiftUI

struct AddScreen: View {
    private var categories: [Category] = [
        Category(category: "Food", style: .food),
        Category(category: "Transport", style: .transport),
        Category(category: "Shopping", style: .shopping),
        Category(category: "Fun", style: .entertainment)
    ]
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // MARK: - State
    @State private var activeCategory: ExpenseCategory = .food
    
    var body: some View {
        VStack {
            Text("Rp 35000")
                .font(.system(size: 52))
                .foregroundStyle(.white)
                .bold()
                .padding(.bottom, 8)
            Text("tap amount to edit")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white.opacity(0.5))
                .padding(.bottom, 20)
            
            TextField("What did you spend on?", text: .constant(""))
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .foregroundStyle(.white)
                .glassEffect(in: .rect(cornerRadius: 12))
                .padding(.bottom, 24)
            
            VStack(alignment: .leading) {
                Text("Category")
                    .textCase(.uppercase)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 12)
                
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(categories.indices, id: \.self) { idx in
                        let cat = categories[idx]
                        let active = activeCategory == cat.style
                        AppCategory(category: cat, active: active)
                            .grayscale(active ? 0 : 1)
                            .onTapGesture {
                                withAnimation(.spring(duration: 0.2)) {
                                    self.activeCategory = cat.style
                                }
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Surface"))
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium])
    }
}


#Preview {
    AddScreen()
}
