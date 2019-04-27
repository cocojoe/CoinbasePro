//
//  CBPOrders.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 20/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// [Orders API](https://docs.gdax.com/#orders)
public class CBPOrders: Builder {

    internal init(request: Request) {
        super.init(path: "/orders", request: request)
    }

    /// List of orders
    ///
    /// - Parameters:
    ///   - withStatus: Limit list of orders to these statuses: "open, pending, active". Default `all` will return all orders.
    ///   - productId: Only list orders for a specific product. Default is `nil` which will match all products.
    ///   - callback: Closure that yields orders information
    public func list(withStatus status: String = "all", productId: String? = nil, callback: @escaping (CoinbaseProError?, (order: [Order]?, pagination: Pagination?)) -> Void) {
        var params = self.params
        params["status"] = status
        params["product_id"] = productId
        self.request.array(model: Order.self, method: "GET", path: self.path, parameters: params, callback: callback)
    }

    /// Place an order
    ///
    /// - Parameters:
    ///   - price: Price per BTC
    ///   - size: Amount of BTC to buy or sell
    ///   - side: "buy" or "sell"
    ///   - productId: A valid product id
    ///   - callback: Closure that yields order placement outcome
    public func buy(withPrice price: String, size: String, side: String, productId: String, callback: @escaping (CoinbaseProError?, Order?) -> Void) {
        var params = self.params
        params["price"] = price
        params["size"] = size
        params["side"] = side
        params["product_id"] = productId
        self.request.object(model: Order.self, method: "POST", path: self.path, parameters: params, callback: callback)
    }
}
