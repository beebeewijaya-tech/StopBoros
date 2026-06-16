//
//  WalletModel.swift
//  StopBoros
//
//  Created by Bee Wijaya on 17/06/26.
//

import SwiftData
import SwiftUI

@Model
final class WalletModel {
    var name: String
    var balance: Double
    var hide: Bool
    var created: Date
    var updated: Date
    
    init(name: String, balance: Double, hide: Bool, created: Date, updated: Date) {
        self.name = name
        self.balance = balance
        self.hide = hide
        self.created = created
        self.updated = updated
    }
}
