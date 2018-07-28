//
//  CoinbasePro.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 06/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// CoinbasePro
public struct CoinbasePro: Loggable {

    let request: Request

    /// Initialise CoinbasePro using API keys. [More Information](https://docs.gdax.com/#private)
    ///
    /// - Parameters:
    ///   - key: The API Key
    ///   - secret: The API Secret
    ///   - phrase: The API Phrase
    ///   - baseURL: The API environment BaseURL, this will default to the live environment if not specified
    ///   - network: Networking instance to use for all requests, see the `Networkable` Protocol to roll your own.
    public init(withAPIKey key: String, secret: String, phrase: String, baseURL: String? = nil, network: Networkable? = nil) {
        self.request = Request(withAPIKey: key, secret: secret, phrase: phrase, baseURL: baseURL, network: network)
    }

    /// Retrun an instance of CBPAccounts
    public var accounts: CBPAccounts {
        return CBPAccounts(request: self.request)
    }

    /// Retrun an instance of CBPOrders
    public var orders: CBPOrders {
        return CBPOrders(request: self.request)
    }
}
