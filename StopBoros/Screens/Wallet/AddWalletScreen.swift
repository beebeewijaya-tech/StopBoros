//
//  AddWalletScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 14/06/26.
//

import SwiftUI
import SwiftData

enum WalletType: String {
    case ewallet, cash, bank, cc
    
    var title: String {
        switch self {
        case .ewallet:
            return "E-Wallet"
        case .cash:
            return "Cash"
        case .bank:
            return "Bank"
        case .cc:
            return "Credit Card"
        }
    }
    
    var background: Color {
        switch self {
        case .ewallet:
            return Color("GreenLight")
        case .cash:
            return Color("Transport")
        case .bank:
            return Color("Shopping")
        case .cc:
            return Color("Entertainment")
        }
    }
    
    var icon: String {
        switch self {
        case .ewallet:
            return "wallet.bifold.fill"
        case .cash:
            return "dollarsign.square.fill"
        case .bank:
            return "wallet.bifold.fill"
        case .cc:
            return "creditcard.fill"
        }
    }
}

struct AddWalletScreen: View {
    // MARK: - State
    @State private var walletName: String = ""
    @State private var startingBalance: String = ""
    @State private var choosenType: WalletType = .ewallet
    
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - Property
    private var walletType: [WalletType] = [
        .ewallet,
        .cash,
        .bank,
        .cc
    ]
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    func addWallet() {
        guard walletName != "", startingBalance != "" else { return }
        guard let bal = Double(startingBalance) else { return }
        
        modelContext.insert(
            WalletModel(
                name: walletName,
                balance: bal,
                type: choosenType.rawValue,
                active: false,
                created: .now,
                updated: .now
            )
        )
        try? modelContext.save()
        
        walletName = ""
        startingBalance = ""
    }
    
    var body: some View {
        VStack {
            AppTextfield(label: "Wallet Name", placeholder: "eg. Gopay, BCA, Spending", description: $walletName)
            AppTextfield(label: "Starting Balance", placeholder: "Rp 0", description: $startingBalance, type: .phone)
            
            LazyVGrid(columns: columns) {
                ForEach(walletType.indices, id: \.self) { idx in
                    let type = walletType[idx]
                    HStack {
                        Image(systemName: type.icon)
                            .font(.caption)
                            .foregroundStyle(choosenType == type ? type.background : .gray)
                        
                        Text(type.title)
                            .font(.caption)
                            .foregroundStyle(choosenType == type ? type.background : .gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("Surface"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(choosenType == type ? type.background : .gray, lineWidth: 2)
                    }
                    .padding(4)
                    .onTapGesture {
                        choosenType = type
                    }
                }
            }
            .padding(.bottom, 20)
            
            AppButton(label: "Add Wallet", style: .primary) {
                addWallet()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Surface"))
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    WalletScreen()
}
