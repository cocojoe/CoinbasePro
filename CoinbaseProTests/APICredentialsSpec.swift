//
//  APICredentialsSpec.swift
//  CoinbaseProTests
//
//  Created by Martin on 10/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class APICredentialsSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should return instance of APICredentials") {
                let credentials = APICredentials(key: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase)
                expect(credentials).to(beAnInstanceOf(APICredentials.self))
            }

            it("should set baseURL to URL of supplied value") {
                let baseURL = URL(string: "https://myapi.com/api")!
                let credentials = APICredentials(key: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase, baseURL: baseURL.absoluteString)
                expect(credentials.baseURL).to(equal(baseURL))
            }

        }

        describe("defaults") {

            let defaultURL = URL(string: "https://api-public.gdax.com")!

            it("should have default URL") {
                let credentials = APICredentials(key: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase)
                expect(credentials.baseURL).to(equal(defaultURL))
            }

        }

        describe("signed headers") {

            var credentials: APICredentials!

            beforeEach {
                credentials = APICredentials(key: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase)
            }

            it("should return valid header dictionary with no body") {
                let timeStamp = String(Int(Date().timeIntervalSince1970))
                let signature = timeStamp + "GET" + "/endpoint"
                let signatureSigned64 = signature.HMAC256Base64(withKey: Constants.APISecret.base64Decode()!)
                let dict = credentials.signedHeader(method: "GET", requestPath: "/endpoint", parameters: [:])
                expect(dict["CB-ACCESS-KEY"]).to(equal(Constants.APIKey))
                expect(dict["CB-ACCESS-SIGN"]).to(equal(signatureSigned64))
                expect(dict["CB-ACCESS-TIMESTAMP"]).to(equal(timeStamp))
                expect(dict["CB-ACCESS-PASSPHRASE"]).to(equal(Constants.APIPhrase))
            }

            it("should return valid header dictionary with body") {
                let timeStamp = String(Int(Date().timeIntervalSince1970))
                let signature = timeStamp + "GET" + "/endpoint" + "the body"
                let signatureSigned64 = signature.HMAC256Base64(withKey: Constants.APISecret.base64Decode()!)
                let dict = credentials.signedHeader(method: "GET", requestPath: "/endpoint", body: "the body", parameters: [:])
                expect(dict["CB-ACCESS-KEY"]).to(equal(Constants.APIKey))
                expect(dict["CB-ACCESS-SIGN"]).to(equal(signatureSigned64))
                expect(dict["CB-ACCESS-TIMESTAMP"]).to(equal(timeStamp))
                expect(dict["CB-ACCESS-PASSPHRASE"]).to(equal(Constants.APIPhrase))
            }

            it("should return valid header dictionary with parameters and body") {
                let timeStamp = String(Int(Date().timeIntervalSince1970))
                let signature = timeStamp + "GET" + "/endpoint?param1=value2" + "the body"
                let signatureSigned64 = signature.HMAC256Base64(withKey: Constants.APISecret.base64Decode()!)
                let dict = credentials.signedHeader(method: "GET", requestPath: "/endpoint", body: "the body", parameters: ["param1": "value2"])
                expect(dict["CB-ACCESS-KEY"]).to(equal(Constants.APIKey))
                expect(dict["CB-ACCESS-SIGN"]).to(equal(signatureSigned64))
                expect(dict["CB-ACCESS-TIMESTAMP"]).to(equal(timeStamp))
                expect(dict["CB-ACCESS-PASSPHRASE"]).to(equal(Constants.APIPhrase))
            }

        }
    }
}
