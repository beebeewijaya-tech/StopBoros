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
    var type: String
    var active: Bool
    var created: Date
    var updated: Date
    
    init(name: String, balance: Double, type: String, active: Bool, created: Date, updated: Date) {
        self.name = name
        self.balance = balance
        self.type = type
        self.active = active
        self.created = created
        self.updated = updated
    }
}
