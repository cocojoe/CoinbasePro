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

    let request: Request

    // MARK: Builder
    let path = "/orders"
    var params: [String: String] = [:]

    internal init(request: Request) {
        self.request = request
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
}

extension CBPOrders: BuilderPagination {

    public func limit(_ limit: Int) -> Self {
        self.params["limit"] = String(limit)
        return self
    }

    public func nextPage(_ next: String) -> Self {
        self.params["after"] = next
        return self
    }

    public func previousPage(_ prev: String) -> Self {
        self.params["before"] = prev
        return self
    }
}
