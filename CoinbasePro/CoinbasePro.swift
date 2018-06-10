//
//  CoinbasePro.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

/// CoinbasePro
public struct CoinbasePro: Loggable {

    private let network: Network

    /// Initialise CoinbasePro using your API keys. [More Information](https://docs.gdax.com/#private)
    ///
    /// - Parameters:
    ///   - key: The API Key
    ///   - secret: The API Secret
    ///   - phrase: The API Phrase
    ///   - baseURL: The API environment BaseURL, this will default to the live environment if not specified
    ///   - network: Networking instance to use for all requests, see the `Networkable` Protocol to roll your own.
    public init(withAPIKey key: String, secret: String, phrase: String, baseURL: String? = nil, network: Networkable? = nil) {
        self.network = Network(withAPIKey: key, secret: secret, phrase: phrase, baseURL: baseURL, network: network)
    }

    /// Create a new instance of CBPAccounts
    ///
    /// - Returns: A CBPAccounts instance
    public func accounts() -> CBPAccounts {
        return CBPAccounts(withNetwork: self.network)
    }
}
