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

    let requestPath = "/accounts"
    let request: Request

    internal init(request: Request) {
        self.request = request
    }

    /// List of trading accounts.
    ///
    /// - Parameter callback: Closure that yields account information or error.
    /// - SeeAlso: [Accounts API](https://docs.gdax.com/#accounts)
    public func list(callback: @escaping (CoinbaseProError?, [Account]?) -> Void) {
        self.request.array(model: Account.self, method: "GET", path: self.requestPath, callback: callback)
    }

    /// Information for a single account. Use this endpoint when you know the account_id.
    ///
    /// - Parameters:
    ///   - accountu: Account ID
    ///   - callback: Closure that yields account information or error.
    public func retrieve(_ account: String, callback: @escaping (CoinbaseProError?, Account?) -> Void) {
        let requestPath = self.requestPath + "/" + account
        self.request.object(model: Account.self, method: "GET", path: requestPath, callback: callback)
    }

    /// List account activity.
    /// Items are paginated and sorted latest first.
    ///
    /// - Parameters:
    ///   - account: Account ID
    ///   - callback: Closure that yields account history information or error.
    public func history(_ account: String, callback: @escaping (CoinbaseProError?, [AccountLedger]?) -> Void) {
        let requestPath = self.requestPath + "/" + account + "/ledger"
        self.request.array(model: AccountLedger.self, method: "GET", path: requestPath, callback: callback)
    }

    /// List of account holds.
    ///
    /// - Parameters:
    ///   - account: Account ID
    ///   - callback: Closure that yields account history information or error.
    public func holds(_ account: String, callback: @escaping (CoinbaseProError?, [AccountHold]?) -> Void) {
        let requestPath = self.requestPath + "/" + account + "/holds"
        self.request.array(model: AccountHold.self, method: "GET", path: requestPath, callback: callback)
    }
}
