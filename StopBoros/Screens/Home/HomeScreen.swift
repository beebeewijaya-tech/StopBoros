//
//  HomeScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 13/06/26.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Environment(ExpenseViewModel.self) private var expenseVM
    
    // MARK: - State
    @State private var progress: CGFloat = 1/10
    
    var body: some View {
        ZStack {
            Color("AppBackground")
                .ignoresSafeArea(.all)
            
            VStack {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("Thursday, June 11")
                            .font(.caption)
                            .foregroundStyle(Color("GrayAsh"))
                        
                        Text("Hey Bee 👋")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .foregroundStyle(.white)
                    }
                    .padding(12)
                    .glassEffect(.clear)
                }
                .padding(.bottom, 20)
                
                AppCard(label: "Spent Today", value: "Rp 100.000", style: .secondary, size: .large, progress: progress) {
                    HStack {
                        AppCard(label: "This Week", value: "Rp 100k", style: .primary, size: .medium, progress: nil) {
                            
                        }
                        AppCard(label: "This Month", value: "Rp 1.2m", style: .primary, size: .medium, progress: nil) {
                            
                        }
                    }
                }
                .padding(.bottom, 20)
                
                
                VStack {
                    Text("You've spent 80% of your food budget — and it's only Wednesday.")
                        .foregroundStyle(Color("Expense"))
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("Alert").opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .fill(Color("Alert"))
                }
                .padding(.bottom, 24)
                
                
                VStack {
                    HStack {
                        Text("Today's Transactions")
                            .font(.body)
                            .foregroundStyle(.white)
                            .bold()
                        Spacer()
                        Text("See all")
                            .font(.body)
                            .foregroundStyle(Color("GrayAsh"))
                    }
                    .padding(.bottom, 12)
                    
                    LazyVStack {
                        ForEach(expenseVM.expenses.indices, id: \.self) { idx in
                            AppExpense(expense: expenseVM.expenses[idx])
                                .padding(.bottom, 12)
                        }
                    }
                }
                Spacer()
            }
            .padding(34)
        }
        .onAppear {
            expenseVM.fetchExpenses()
        }
    }
}

#Preview {
    HomeScreen()
}
