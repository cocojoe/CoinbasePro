//
//  APIErrorSpec.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 10/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class APIErrorSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should return instance of APIError") {
                let account = APIError(description: "A big error")
                expect(account).to(beAnInstanceOf(APIError.self))
            }

        }

        describe("decodable") {
            it("should decode and return APIError instance from account JSON") {
                let jsonData = JSONData(fromFile: Constants.JSONAPIErrorObject)
                let result = try? JSONDecoder().decode(APIError.self, from: jsonData)
                expect(result).to(beAnInstanceOf(APIError.self))
            }
        }

    }
}
