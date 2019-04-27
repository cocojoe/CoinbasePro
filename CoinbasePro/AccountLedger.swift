//
//  AccountLedger.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 13/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// Data Model for Account Ledger Information
/// See [Account History](https://docs.gdax.com/#get-account-history)
public struct AccountLedger {

    public let id: UInt
    public let createdAt: String
    public let amount: String
    public let balance: String
    public let type: String
    public let details: AccountLedgerDetail
}

extension AccountLedger: Decodable { }
