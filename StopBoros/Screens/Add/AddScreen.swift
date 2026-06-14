//
//  AddScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 13/06/26.
//

import SwiftUI


enum FormError {
    case empty, tooSmall, invalidFormat
    
    
    var formatError: String? {
        switch self {
        case .empty:
            return "Amount is required"
        case .tooSmall:
            return "Amount must be atleast Rp 100"
        case .invalidFormat:
            return "Enter numbers only"
        }
    }
}

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
    @State private var amount: String = "0"
    @State private var description: String = ""
    @State private var isAmountDirty: Bool = false
    @State private var isDescriptionDirty: Bool = false
    @FocusState private var isAmountFocus: Bool
    
    // MARK: - Action & computed
    var action: () -> Void
    var amountError: FormError? {
        if !isAmountDirty { return nil }
        if amount.isEmpty { return .empty }
        guard let amt = Int(amount) else { return .invalidFormat }
        if amt < 100 { return .tooSmall }
        return nil
    }
    var descriptionError: FormError? {
        if !isDescriptionDirty { return nil }
        if description.isEmpty { return .empty }
        return nil
    }
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    // MARK: - Environment
    @Environment(ExpenseViewModel.self) private var expenseVM
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Rp.")
                    .font(.system(size: 52))
                    .foregroundStyle(.white)
                    .bold()
                
                TextField("", text: $amount)
                    .font(.system(size: 52))
                    .foregroundStyle(.white)
                    .bold()
                    .keyboardType(.numberPad)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 50)
                    .focused($isAmountFocus)
            }
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.red, lineWidth: (amountError != nil) ? 2 : 0)
            )
            .padding(12)

            
            Text((amountError != nil ? amountError?.formatError : "tap amount to edit") ?? "")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle((amountError != nil) ? .red : .white.opacity(0.5))
                .padding(.bottom, 20)
            
            TextField("What did you spend on?", text: $description)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .foregroundStyle(.white)
                .glassEffect(in: .rect(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.red, lineWidth: (descriptionError != nil) ? 2 : 0)
                )
                .keyboardType(.default)
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
            .padding(.bottom, 20)
            
            Button {
                isAmountDirty = true
                isDescriptionDirty = true
                guard amountError == nil, descriptionError == nil else { return }
                
                expenseVM.addExpense(expense: Expense(expense: description, category: activeCategory, amount: Double(amount) ?? 0))
                action()
            } label: {
                VStack {
                    Text("Add Expense")
                        .foregroundStyle(Color("GreenLight"))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color("CardBackground"))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color("GreenLight"), lineWidth: 2)
                )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 10)
        .background(Color("Surface"))
        .presentationDragIndicator(.visible)
        .onChange(of: amount) { _, new in
            var processed = new
            
            if processed.hasPrefix("0") {
                processed = String(new.dropFirst())
            }
            
            if processed != new {
                amount = processed
            }
            
            if isAmountDirty {
                isAmountDirty = false
            }
        }
        .onChange(of: description, { _, _ in
            if isDescriptionDirty {
                isDescriptionDirty = false
            }
        })
        .onAppear {
            isAmountFocus = true
        }
    }
}


#Preview {
    AddScreen() {
        
    }
}
