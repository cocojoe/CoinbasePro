//
//  AccountHold.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 14/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
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

extension AccountHold: Decodable { }
