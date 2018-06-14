//
//  CBPAccountsSpec.swift
//  CoinbaseProTests
//
//  Created by Martin on 10/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro


class CBPAccountsSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should return instance of CBPAccounts") {
                let request  = Request(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase, network: NetworkMock())
                let accounts = CBPAccounts(request: request)
                expect(accounts).to(beAnInstanceOf(CBPAccounts.self))
            }
        }

        describe("accounts") {

            var network: NetworkMock!
            var request: Request!
            var accounts: CBPAccounts!

            beforeEach {
                network = NetworkMock()
                request  = Request(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase, network: network)
                accounts = CBPAccounts(request: request)
            }

            context("list accounts") {

                it("should yield array of account objects") {
                    network.setJSONData(fromFile: Constants.Accounts.JSONArray)
                    accounts.list { error, accounts in
                        expect(error).to(beNil())
                        expect(accounts?.first).to(beAnInstanceOf(Account.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.list { error, accounts in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(accounts).to(beNil())
                    }
                }
            }

            context("retrieve account") {

                it("should yield single account object") {
                    network.setJSONData(fromFile: Constants.Accounts.JSONObject)
                    accounts.retrieve("ID1") { error, account in
                        expect(error).to(beNil())
                        expect(account).to(beAnInstanceOf(Account.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.retrieve("ID1") { error, account in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(account).to(beNil())
                    }
                }
            }

            context("account history") {

                it("should yield account ledger object") {
                    network.setJSONData(fromFile: Constants.Accounts.JSONHistoryArray)
                    accounts.history("ID1") { error, history in
                        expect(error).to(beNil())
                        expect(history?.first).to(beAnInstanceOf(AccountLedger.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.history("ID1") { error, history in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(history).to(beNil())
                    }
                }
            }

            context("account hold") {

                it("should yield accountuhold object") {
                    network.setJSONData(fromFile: Constants.Accounts.JSONHoldArray)
                    accounts.holds("ID1") { error, history in
                        expect(error).to(beNil())
                        expect(history?.first).to(beAnInstanceOf(AccountHold.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.holds("ID1") { error, history in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(history).to(beNil())
                    }
                }
            }
        }

    }
}
