//
//  Account.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 06/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// Data Model for Account Information
/// See [Accounts](https://docs.gdax.com/#list-accounts)
public struct Account {

    public let available: String
    public let balance: String
    public let currency: String
    public let hold: String
    public let id: String
    public let profileId: String

    init(available: String, balance: String, currency: String, hold: String, id: String, profileId: String) {
        self.available = available
        self.balance = balance
        self.currency = currency
        self.hold = hold
        self.id = id
        self.profileId = profileId
    }
}

extension Account: Decodable { }
