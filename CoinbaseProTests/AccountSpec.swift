//
//  AccountSpec.swift
//  CoinbaseProTests
//
//  Created by Martin on 10/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class AccountSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should return instance of Account") {
                let account = Account(available: "0.00", balance: "100.0", currency: "BTC", hold: "0", id: "341133", profileId: "3455-abc45")
                expect(account).to(beAnInstanceOf(Account.self))
            }

        }

        describe("decodable") {
            it("should decode and return Account instance from account JSON") {
                let jsonData = JSONData(fromFile: Constants.JSONAccountObject)
                let result = try? JSONDecoder().decode(Account.self, from: jsonData)
                expect(result).to(beAnInstanceOf(Account.self))
            }
        }

    }
}
