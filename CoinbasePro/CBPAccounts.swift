//
//  CBPAccounts.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

public struct CBPAccounts {

    private let dataModel = Account.self
    private let requestPath = "/accounts"
    private let network: Network

    internal init(withNetwork network: Network) {
        self.network = network
    }

    /// Get a list of trading accounts.
    ///
    /// - Parameter callback: Closure that yields account information or error.
    public func getAccounts(callback: @escaping (CoinbaseProError?, [Account]?) -> Void) {
        self.network.requestArray(model: self.dataModel, method: "GET", path: self.requestPath, callback: callback)
    }

    /// Information for a single account. Use this endpoint when you know the account_id.
    ///
    /// - Parameters:
    ///   - id: Account ID
    ///   - callback: Closure that yields account information or error.
    public func getAccount(withID id: String, callback: @escaping (CoinbaseProError?, Account?) -> Void) {
        let requestPath = self.requestPath + "/" + id
        self.network.request(model: self.dataModel, method: "GET", path: requestPath, callback: callback)
    }
}
