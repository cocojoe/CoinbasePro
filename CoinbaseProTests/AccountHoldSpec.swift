//
//  AccountHoldSpec.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 14/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class AccountHoldSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should return instance of AccountHold") {
                let ledger = AccountHold(id: "e3327720-dc85-461c-a3d9-513727948478", createdAt: "2018-06-14T10:54:32.168367Z", amount: "0.0100000000000000", type: "order", ref: "ef923b39-a311-4e6c-9e16-f2bce5317bab")
                expect(ledger).to(beAnInstanceOf(AccountHold.self))
            }

        }

        describe("decodable") {
            it("should decode and return AccountHold from JSON") {
                let jsonData = JSONData(fromFile: Constants.Accounts.JSONHoldArray)
                let result = try? JSONDecoder()
                    .caseDecoder()
                    .decode([AccountHold].self, from: jsonData)
                expect(result?.first).to(beAnInstanceOf(AccountHold.self))
            }
        }

    }
}
