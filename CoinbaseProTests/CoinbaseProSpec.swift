//
//  CoinbaseProTests.swift
//  CoinbaseProTests
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class CoinbaseProSpec: QuickSpec {
    override func spec() {

        describe("init") {
            it("should return instance of CoinbasePro") {
                let coinbase = CoinbasePro(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase)
                expect(coinbase).to(beAnInstanceOf(CoinbasePro.self))
            }
        }

        describe("instance accessors") {

            var coinbase: CoinbasePro!

            beforeEach {
                coinbase = CoinbasePro(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase)
            }

            it("should return instance of Accounts") {
                expect(coinbase.accounts).to(beAnInstanceOf(CBPAccounts.self))
            }

        }
    }
}
