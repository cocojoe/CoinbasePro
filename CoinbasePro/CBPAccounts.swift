//
//  CBPAccounts.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

/// [Accounts API](https://docs.gdax.com/#accounts)
public struct CBPAccounts: Builder {

    let request: Request

    // MARK: Builder
    let path = "/accounts"
    var params: [String: String] = [:]

    internal init(request: Request) {
        self.request = request
    }

    /// List of trading accounts.
    ///
    /// - Parameter callback: Closure that yields account information or error.
    /// - SeeAlso: [Accounts API](https://docs.gdax.com/#accounts)
    public func list(callback: @escaping (CoinbaseProError?, [Account]?) -> Void) {
        self.request.array(model: Account.self, method: "GET", path: self.path, parameters: self.params, callback: callback)
    }

    /// Information for a single account. Use this endpoint when you know the account_id.
    ///
    /// - Parameters:
    ///   - accountu: Account ID
    ///   - callback: Closure that yields account information or error.
    public func retrieve(_ account: String, callback: @escaping (CoinbaseProError?, Account?) -> Void) {
        let requestPath = self.path + "/" + account
        self.request.object(model: Account.self, method: "GET", path: requestPath, parameters: self.params, callback: callback)
    }

    /// List account activity.
    /// Items are paginated and sorted latest first.
    ///
    /// - Parameters:
    ///   - account: Account ID
    ///   - callback: Closure that yields account history information or error.
    public func history(_ account: String, callback: @escaping (CoinbaseProError?, [AccountLedger]?) -> Void) {
        let requestPath = self.path + "/" + account + "/ledger"
        self.request.array(model: AccountLedger.self, method: "GET", path: requestPath, parameters: self.params, callback: callback)
    }

    /// List of account holds.
    ///
    /// - Parameters:
    ///   - account: Account ID
    ///   - callback: Closure that yields account history information or error.
    public func holds(_ account: String, callback: @escaping (CoinbaseProError?, [AccountHold]?) -> Void) {
        let requestPath = self.path + "/" + account + "/holds"
        self.request.array(model: AccountHold.self, method: "GET", path: requestPath, parameters: self.params, callback: callback)
    }
}
