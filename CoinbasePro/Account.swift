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

extension Account: Decodable {
    enum CodingKeys: String, CodingKey {
        case available
        case balance
        case currency
        case hold
        case id
        case profileId = "profile_id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let available: String = try container.decode(String.self, forKey: .available)
        let balance: String = try container.decode(String.self, forKey: .balance)
        let currency: String = try container.decode(String.self, forKey: .currency)
        let hold: String = try container.decode(String.self, forKey: .hold)
        let id: String = try container.decode(String.self, forKey: .id)
        let profileId: String = try container.decode(String.self, forKey: .profileId)

        self.init(available: available, balance: balance, currency: currency, hold: hold, id: id, profileId: profileId)
    }
}
