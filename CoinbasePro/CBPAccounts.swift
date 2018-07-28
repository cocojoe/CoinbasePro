//
//  CBPAccounts.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 06/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// [Accounts API](https://docs.gdax.com/#accounts)
public class CBPAccounts: Builder {

    let request: Request

    // MARK: Builder
    let path = "/accounts"
    var params: [String: String] = [:]

    internal init(request: Request) {
        self.request = request
    }

    /// List of trading accounts.
    ///
    /// - Parameter callback: Closure that yields all trading accounts
    public func list(callback: @escaping (CoinbaseProError?, (account: [Account]?, pagination: Pagination?)) -> Void) {
        self.request.array(model: Account.self, method: "GET", path: self.path, parameters: self.params, callback: callback)
    }

    /// Information for a single account. Use this endpoint when you know the account_id.
    ///
    /// - Parameters:
    ///   - account: Account ID
    ///   - callback: Closure that yields a single account
    public func retrieve(_ account: String, callback: @escaping (CoinbaseProError?, Account?) -> Void) {
        let requestPath = self.path + "/" + account
        self.request.object(model: Account.self, method: "GET", path: requestPath, parameters: self.params, callback: callback)
    }

    /// List account activity.
    /// Items are paginated and sorted latest first.
    ///
    /// - Parameters:
    ///   - account: Account ID
    ///   - callback: Closure that yields an accounts history
    public func history(_ account: String, callback: @escaping (CoinbaseProError?, (accountLedger: [AccountLedger]?, pagination: Pagination?)) -> Void) {
        let requestPath = self.path + "/" + account + "/ledger"
        self.request.array(model: AccountLedger.self, method: "GET", path: requestPath, parameters: self.params, callback: callback)
    }

    /// List of account holds.
    ///
    /// - Parameters:
    ///   - account: Account ID
    ///   - callback: Closure that yields account holds
    public func holds(_ account: String, callback: @escaping (CoinbaseProError?, (accountHold: [AccountHold]?, pagination: Pagination?)) -> Void) {
        let requestPath = self.path + "/" + account + "/holds"
        self.request.array(model: AccountHold.self, method: "GET", path: requestPath, parameters: self.params, callback: callback)
    }
}

extension CBPAccounts: BuilderPagination {

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
