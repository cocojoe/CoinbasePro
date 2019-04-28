//
//  NetworkFireSpec.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 11/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
@testable import CoinbasePro

private let Host = "test.localhost"
private let BaseURL = URL(string: "https://" + Host)

class NetworkFireSpec: QuickSpec {

    override func spec() {

        describe("making requests") {

            var network: NetworkFire!

            beforeEach {
                network = NetworkFire()
                stub(condition: isHost(Host) && isPath("/simple") && isMethodGET()) { _ in
                    return OHHTTPStubsResponse(data: JSONData(fromFile: Constants.JSONSimpleObject), statusCode: 200, headers: ["Content-Type":"application/json"])
                    }.name = "Success JSON 200"
                stub(condition: isHost(Host) && isPath("/simple") && isMethodPOST() && hasBody("JSON_BODY".data(using: .utf8)!)) { _ in
                    return OHHTTPStubsResponse(data: JSONData(fromFile: Constants.JSONSimpleObject), statusCode: 200, headers: ["Content-Type":"application/json"])
                    }.name = "Success JSON 200"
                stub(condition: isHost(Host) && isPath("/simple/fail-with-error") && isMethodGET()) { _ in
                    return OHHTTPStubsResponse(data: JSONData(fromFile: Constants.JSONAPIErrorObject), statusCode: 400, headers: ["Content-Type":"application/json"])
                    }.name = "Failure JSON 400 with Error JSON"
                stub(condition: isHost(Host) && isPath("/simple/fail") && isMethodGET()) { _ in
                    return OHHTTPStubsResponse(data: "".data(using: .utf8)!, statusCode: 400, headers: ["Content-Type":"application/json"])
                    }.name = "Failure JSON 400"
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("should yield success JSON data on GET") {
                let requestURL = URL(string: "/simple", relativeTo: BaseURL)!
                waitUntil(timeout: Constants.Timeout) { done in
                    network.makeRequest(method: "GET", requestURL: requestURL, parameters: [:], headers: [:]) { error, result in
                        expect(error).to(beNil())
                        expect(result.0).to(beAnInstanceOf(Data.self))
                        done()
                    }
                }
            }
            
            it("should yield success JSON data on POST") {
                let requestURL = URL(string: "/simple", relativeTo: BaseURL)!
                waitUntil(timeout: Constants.Timeout) { done in
                    network.makeRequest(method: "POST", requestURL: requestURL, body: "JSON_BODY", parameters: [:], headers: ["key1": "value1"]) { error, result in
                        expect(error).to(beNil())
                        expect(result.0).to(beAnInstanceOf(Data.self))
                        done()
                    }
                }
            }

            it("should fail and return networkError with 400 and JSON error data)") {
                let requestURL = URL(string: "/simple/fail-with-error", relativeTo: BaseURL)!
                waitUntil(timeout: Constants.Timeout) { done in
                    network.makeRequest(method: "GET", requestURL: requestURL, parameters: [:], headers: [:]) { error, result in
                        expect(error).to(equal(CoinbaseProError.networkError))
                        expect(result.0).to(beNil())
                        done()
                    }
                }
            }

            it("should fail and return networkError on 400") {
                let requestURL = URL(string: "/simple/fail", relativeTo: BaseURL)!
                waitUntil(timeout: Constants.Timeout) { done in
                    network.makeRequest(method: "GET", requestURL: requestURL, parameters: [:], headers: [:]) { error, result in
                        expect(error).to(equal(CoinbaseProError.networkError))
                        expect(result.0).to(beNil())
                        done()
                    }
                }
            }
        }
    }
}
