//
//  AccountLedgerDetail.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 13/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// Data Model for Account Ledger Detail Information
/// See [Account History](https://docs.gdax.com/#get-account-history)
public struct AccountLedgerDetail {

    public let orderId: String
    public let tradeId: String
    public let productId: String

    init(orderId: String, tradeId: String, productId: String) {
        self.orderId = orderId
        self.tradeId = tradeId
        self.productId = productId
    }
}
