//
//  AccountLedgerSpec.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 14/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class AccountLedgerSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should return instance of AccountLedger") {
                let ledger = AccountLedger(id: 39549434, createdAt: "2018-06-14T09:44:50.99495Z", amount: "0.0152889400000000", balance: "0.1681783900000000", type: "BTC-USD", details: AccountLedgerDetail(orderId: "2d5cae54-5b8f-459e-a8fa-e7004f098b67", tradeId: "1833054", productId: "BTC-USD"))
                expect(ledger).to(beAnInstanceOf(AccountLedger.self))
            }

        }

        describe("decodable") {
            it("should decode and return AccountLedger from JSON") {
                let jsonData = JSONData(fromFile: Constants.Accounts.JSONHistoryArray)
                let result = try? JSONDecoder().decode([AccountLedger].self, from: jsonData)
                expect(result?.first).to(beAnInstanceOf(AccountLedger.self))
            }
        }

    }
}
