//
//  CBPAccounts.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

/// [Accounts API](https://docs.gdax.com/#accounts)
public struct CBPAccounts {

    let dataModel = Account.self
    let requestPath = "/accounts"
    let request: Request

    internal init(request: Request) {
        self.request = request
    }

    /// Get a list of trading accounts.
    ///
    /// - Parameter callback: Closure that yields account information or error.
    /// - SeeAlso: [Accounts API](https://docs.gdax.com/#accounts)
    public func getAccounts(callback: @escaping (CoinbaseProError?, [Account]?) -> Void) {
        self.request.array(model: self.dataModel, method: "GET", path: self.requestPath, callback: callback)
    }

    /// Information for a single account. Use this endpoint when you know the account_id.
    ///
    /// - Parameters:
    ///   - id: Account ID
    ///   - callback: Closure that yields account information or error.
    public func getAccount(withID id: String, callback: @escaping (CoinbaseProError?, Account?) -> Void) {
        let requestPath = self.requestPath + "/" + id
        self.request.object(model: self.dataModel, method: "GET", path: requestPath, callback: callback)
    }
}
