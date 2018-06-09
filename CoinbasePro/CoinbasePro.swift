//
//  CoinbasePro.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

public struct CoinbasePro: Loggable {

    let network: Network

    public init(withAPIKey key: String, secret: String, phrase: String, baseURL: String?) {
        self.network = Network(withAPIKey: key, secret: secret, phrase: phrase, baseURL: baseURL)
    }

    public func accounts() -> CBPAccounts {
        return CBPAccounts(withNetwork: self.network)
    }
}
