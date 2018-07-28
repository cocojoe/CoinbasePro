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

    init(id: String, price: String?, size: String?, productId: String, side: String, stp: String?, type: String, timeInForce: String?, postOnly: Bool?, createdAt: String, fillFees: String, filledSize: String, executedValue: String, status: String, settled: Bool, funds: String?, specifiedFunds: String?) {
        self.id = id
        self.price = price
        self.size = size
        self.productId = productId
        self.side = side
        self.stp = stp
        self.type = type
        self.timeInForce = timeInForce
        self.postOnly = postOnly
        self.createdAt = createdAt
        self.fillFees = fillFees
        self.filledSize = filledSize
        self.executedValue = executedValue
        self.status = status
        self.settled = settled
        self.funds = funds
        self.specifiedFunds = specifiedFunds
    }

}

extension Order: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case price
        case size
        case productId = "product_id"
        case side
        case stp
        case type
        case timeInForce = "time_in_force"
        case postOnly = "post_only"
        case createdAt = "created_at"
        case fillFees = "fill_fees"
        case filledSize = "filled_size"
        case executedValue = "executed_value"
        case status
        case settled
        case funds
        case specifiedFunds = "specified_funds"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let price: String? = try container.decodeIfPresent(String.self, forKey: .price)
        let size: String? = try container.decodeIfPresent(String.self, forKey: .size)
        let productId: String = try container.decode(String.self, forKey: .productId)
        let side: String = try container.decode(String.self, forKey: .side)
        let stp: String? = try container.decodeIfPresent(String.self, forKey: .stp)
        let type: String = try container.decode(String.self, forKey: .type)
        let timeInForce: String? = try container.decodeIfPresent(String.self, forKey: .timeInForce)
        let postOnly: Bool? = try container.decodeIfPresent(Bool.self, forKey: .postOnly)
        let createdAt: String = try container.decode(String.self, forKey: .createdAt)
        let fillFees: String = try container.decode(String.self, forKey: .fillFees)
        let filledSize: String = try container.decode(String.self, forKey: .filledSize)
        let status: String = try container.decode(String.self, forKey: .status)
        let executedValue: String = try container.decode(String.self, forKey: .executedValue)
        let settled: Bool = try container.decode(Bool.self, forKey: .settled)
        let funds: String? = try container.decodeIfPresent(String.self, forKey: .funds)
        let specifiedFunds: String? = try container.decodeIfPresent(String.self, forKey: .specifiedFunds)

        self.init(id: id, price: price, size: size, productId: productId, side: side, stp: stp, type: type, timeInForce: timeInForce, postOnly: postOnly, createdAt: createdAt, fillFees: fillFees, filledSize: filledSize, executedValue: executedValue, status: status, settled: settled, funds: funds, specifiedFunds: specifiedFunds)
    }
}
