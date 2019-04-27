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

}

extension Account: Decodable { }
