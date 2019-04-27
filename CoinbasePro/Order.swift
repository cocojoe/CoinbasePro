//
//  Order.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 19/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// Data Model for Order Information
/// See [Orders](https://docs.gdax.com/#orders)
public struct Order {

    public let id: String
    public let price: String? // Applies to Limit Orders
    public let size: String?  // Applies to Limit Orders
    public let productId: String
    public let side: String
    public let stp: String?
    public let type: String
    public let timeInForce: String? // Applies to Limit Orders
    public let postOnly: Bool? // Applies to Limit Orders
    public let createdAt: String
    public let fillFees: String
    public let filledSize: String
    public let executedValue: String
    public let status: String
    public let settled: Bool
    public let funds: String? // Either funds or size is specified
    public let specifiedFunds: String?

}

extension Order: Decodable { }
