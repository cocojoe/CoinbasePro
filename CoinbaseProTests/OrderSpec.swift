//
//  OrderSpec.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 20/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class OrderSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should return instance of Order") {
                let order = Order(id: "270b7d6e-83f6-445b-b963-e853a42b3b11", price: "200", size: nil, productId: "BTC-USD", side: "buy", stp: nil, type: "limit", timeInForce: "GTC", postOnly: nil, createdAt: "2018-06-20T19:57:18.460987Z", fillFees: "0.0000000000000000", filledSize: "0.0000000000000000", executedValue: "0.0000000000000000", status: "open", settled: false, funds: nil, specifiedFunds: nil)
                expect(order).to(beAnInstanceOf(Order.self))
            }

        }

        describe("decodable") {
            it("should decode and return Order instance from JSON") {
                let jsonData = JSONData(fromFile: Constants.Orders.JSONObject)
                let result = try? JSONDecoder()
                    .caseDecoder()
                    .decode(Order.self, from: jsonData)
                expect(result).to(beAnInstanceOf(Order.self))
            }
        }

    }
}
