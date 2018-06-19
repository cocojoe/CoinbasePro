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
                    accounts.list { error, result in
                        expect(error).to(beNil())
                        expect(result.account).to(beAnInstanceOf(Array<Account>.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.list { error, result in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(result.account).to(beNil())
                    }
                }
            }

            context("retrieve account") {

                it("should yield single account object") {
                    network.setJSONData(fromFile: Constants.Accounts.JSONObject)
                    accounts.retrieve("ID1") { error, result in
                        expect(error).to(beNil())
                        expect(result).to(beAnInstanceOf(Account.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.retrieve("ID1") { error, result in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(result).to(beNil())
                    }
                }
            }

            context("account history") {

                it("should yield account ledger object") {
                    network.setJSONData(fromFile: Constants.Accounts.JSONHistoryArray)
                    accounts.history("ID1") { error, result in
                        expect(error).to(beNil())
                        expect(result.accountLedger).to(beAnInstanceOf(Array<AccountLedger>.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.history("ID1") { error, result in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(result.accountLedger).to(beNil())
                    }
                }
            }

            context("account hold") {

                it("should yield accountuhold object") {
                    network.setJSONData(fromFile: Constants.Accounts.JSONHoldArray)
                    accounts.holds("ID1") { error, result in
                        expect(error).to(beNil())
                        expect(result.accountHold).to(beAnInstanceOf(Array<AccountHold>.self))
                    }
                }

                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    accounts.holds("ID1") { error, result in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(result.accountHold).to(beNil())
                    }
                }
            }

            context("pagination") {
                it("should set limit") {
                    let account = accounts.limit(5)
                    expect(account.params["limit"]) == String(5)
                }

                it("should set before") {
                    let account = accounts.nextPage("PAGE1")
                    expect(account.params["after"]) == "PAGE1"
                }

                it("should set after") {
                    let account = accounts.previousPage("PAGE2")
                    expect(account.params["before"]) == "PAGE2"
                }
            }
        }
    }
}
