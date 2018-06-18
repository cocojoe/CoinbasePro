//
//  RequestSpec.swift
//  CoinbaseProTests
//
//  Created by Martin on 11/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class RequestSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should init with default networkable instance") {
                let request = Request(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase)
                expect(request.network).to(beAnInstanceOf(NetworkFire.self))
            }

            it("should init with mock networkable instance") {
                let request = Request(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase, network: NetworkMock())
                expect(request.network).to(beAnInstanceOf(NetworkMock.self))
            }

        }

        describe("request an array") {

            var requestMock: NetworkMock!
            var request: Request!

            beforeEach {
                requestMock = NetworkMock()
                request = Request(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase, network: requestMock)
            }

            context("array decoding") {

                it("should decode a JSON array and yield a model array instance") {
                    requestMock.setJSONData(fromFile: Constants.JSONSimpleArray)
                    request.array(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(beNil())
                        expect($1).to(beAnInstanceOf(Array<SimpleModel>.self))
                    }
                }

                it("should yield decode error when using bad json data") {
                    requestMock.setInvalidJSONData()
                    request.array(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(equal(CoinbaseProError.decodeError))
                        expect($1).to(beNil())
                    }
                }

                it("should yield network error when request failed") {
                    requestMock.setNetworkFailed()
                    request.array(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(equal(CoinbaseProError.networkError))
                        expect($1).to(beNil())
                    }
                }

                it("should yield data error when data missing") {
                    requestMock.setMissingData()
                    request.array(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(equal(CoinbaseProError.dataError))
                        expect($1).to(beNil())
                    }
                }

                context("pagination") {
                    
                }
            }

            context("object decoding") {
                it("should decode a JSON object and yield a model instance") {
                    requestMock.setJSONData(fromFile: Constants.JSONSimpleObject)
                    request.object(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(beNil())
                        expect($1).to(beAnInstanceOf(SimpleModel.self))
                    }
                }

                it("should yield decode error when using bad json data") {
                    requestMock.setInvalidJSONData()
                    request.object(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(equal(CoinbaseProError.decodeError))
                        expect($1).to(beNil())
                    }
                }

                it("should yield network error when request failed") {
                    requestMock.setNetworkFailed()
                    request.object(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(equal(CoinbaseProError.networkError))
                        expect($1).to(beNil())
                    }
                }

                it("should yield data error when data missing") {
                    requestMock.setMissingData()
                    request.object(model: SimpleModel.self, method: "GET", path: "/dummy") {
                        expect($0).to(equal(CoinbaseProError.dataError))
                        expect($1).to(beNil())
                    }
                }

            }

        }

    }
}
