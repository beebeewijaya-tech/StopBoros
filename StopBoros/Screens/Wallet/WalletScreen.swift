//
//  WalletScreen.swift
//  StopBoros
//
//  Created by Bee Wijaya on 14/06/26.
//

import SwiftUI
import SwiftData

struct WalletItem: View {
    var wallet: WalletModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(wallet.name)
                    .foregroundStyle(.white)
                    .bold()
                    .font(.body)
                
                Text(wallet.type)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Rp \(wallet.balance, specifier: "%.2f")")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.body)
                
                if wallet.active {
                    Text("active")
                        .font(.caption)
                        .foregroundStyle(Color("GreenLight"))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("CardBackground"))
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.5), radius: 12)
    }
}

struct WalletScreen: View {
    
    // MARK: - State
    @Query(sort: \WalletModel.updated, order: .reverse) private var wallets: [WalletModel]
    
    var sortedActiveWallet: [WalletModel] {
        return wallets.sorted { $0.active && !$1.active}
    }
    
    var body: some View {
        Group {
            if wallets.count < 1 {
                Text("Empty wallets")
            } else {
                List {
                    ForEach(sortedActiveWallet.indices, id: \.self) { idx in
                        let wallet = sortedActiveWallet[idx]
                        WalletItem(wallet: wallet)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color("Surface"))
                            .swipeActions {
                                Button {
                                    wallet.active.toggle()
                                } label: {
                                    VStack {
                                        Image(systemName: wallet.active ? "eye.slash.fill" : "eye.fill")
                                            .tint(.black)
                                            .font(.caption)
                                            .bold()
                                        
                                        Text(wallet.active ? "Disable" : "Enable")
                                            .tint(.black)
                                            .font(.caption)
                                            .bold()
                                    }
                                    .padding()
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color("Surface"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WalletScreen()
}
