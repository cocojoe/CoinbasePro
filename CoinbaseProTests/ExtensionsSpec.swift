//
//  ExtensionsSpec.swift
//  CoinbaseProTests
//
//  Created by Martin on 10/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class ExtensionsSpec: QuickSpec {
    override func spec() {

        describe("base64 string extension") {

            let base64Decoded = "a small string to encode"
            let base64 = "YSBzbWFsbCBzdHJpbmcgdG8gZW5jb2Rl"

            it("should return nil with invalid input") {
                let input = "not a base64 encoded string"
                expect(input.base64Decode()).to(beNil())
            }

            it("should return valid decoded data") {
                let data = base64.base64Decode()!
                let dataString = String(data: data, encoding: .utf8)
                expect(data).to(beAnInstanceOf(Data.self))
                expect(dataString).to(equal(base64Decoded))
            }

        }

        describe("hmac string extension") {

            let encryptedResult = "LSyhvedpHR7P4AjzIKCxE9brXLMDPWL4fdYl8QPGMPg="

            it("should return valid string") {
                let body = "body to encrypt"
                let key = "the key".data(using: .utf8)!
                expect(body.HMAC256Base64(withKey: key)).to(equal(encryptedResult))
            }
        }
    }
}
