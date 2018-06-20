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

extension AccountLedger: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case amount
        case balance
        case type
        case details
    }

    enum DetailKeys: String, CodingKey {
        case orderId = "order_id"
        case tradeId = "trade_id"
        case productId = "product_id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: UInt = try container.decode(UInt.self, forKey: .id)
        let createdAt: String = try container.decode(String.self, forKey: .createdAt)
        let amount: String = try container.decode(String.self, forKey: .amount)
        let balance: String = try container.decode(String.self, forKey: .balance)
        let type: String = try container.decode(String.self, forKey: .type)

        let nestedContainer = try container.nestedContainer(keyedBy: DetailKeys.self, forKey: .details)
        let orderId: String = try nestedContainer.decode(String.self, forKey: .orderId)
        let tradeId: String = try nestedContainer.decode(String.self, forKey: .tradeId)
        let productId: String = try nestedContainer.decode(String.self, forKey: .productId)

        self.init(id: id, createdAt: createdAt, amount: amount, balance: balance, type: type, details: AccountLedgerDetail(orderId: orderId, tradeId: tradeId, productId: productId))
    }
}
