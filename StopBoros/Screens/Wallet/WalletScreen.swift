//
//  WalletScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 14/06/26.
//

import SwiftUI
import SwiftData

struct WalletScreen: View {
    // MARK: - State
    @State private var walletName: String = ""
    @State private var startingBalance: String = ""
    
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    
    
    func addWallet() {
        guard walletName != "", startingBalance != "" else { return }
        guard let bal = Double(startingBalance) else { return }
        
        modelContext.insert(WalletModel(name: walletName, balance: bal, hide: false, created: .now, updated: .now))
        try? modelContext.save()
        
        walletName = ""
        startingBalance = ""
    }
    
    var body: some View {
        VStack {
            AppTextfield(label: "Wallet Name", placeholder: "eg. Gopay, BCA, Spending", description: $walletName)
            AppTextfield(label: "Starting Balance", placeholder: "Rp 0", description: $startingBalance, type: .phone)
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
