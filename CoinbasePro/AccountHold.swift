//
//  AccountHold.swift
//  CoinbasePro
//
//  Created by Martin on 14/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

/// Data Model for Account Hold Information
/// See [Account Holds](https://docs.gdax.com/#get-holds)
public struct AccountHold {

    public let id: String
    public let createdAt: String
    public let amount: String
    public let type: String
    public let ref: String
}

extension AccountHold: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case amount
        case type
        case ref
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let createdAt: String = try container.decode(String.self, forKey: .createdAt)
        let amount: String = try container.decode(String.self, forKey: .amount)
        let type: String = try container.decode(String.self, forKey: .type)
        let ref: String = try container.decode(String.self, forKey: .ref)

        self.init(id: id, createdAt: createdAt, amount: amount, type: type, ref: ref)
    }
}
