//
//  NetworkMock.swift
//  CoinbaseProTests
//
//  Created by Martin on 11/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
@testable import CoinbasePro

class NetworkMock: Networkable {

    var error: CoinbaseProError?
    var data: Data?
    var pagination: [String: String]?

    func makeRequest(method: String, requestURL: URL, parameters: [String: String], headers: [String: String], callback: @escaping (CoinbaseProError?, Data?, [String: String]?) -> Void) {
        callback(error, data, pagination)
    }

    func setJSONData(fromFile fileName: String) {
        self.data = JSONData(fromFile: fileName)
        self.error = nil
    }

    func setInvalidJSONData() {
        self.data = "Bad Data".data(using: .utf8)
        self.error = nil
    }

    func setNetworkFailed() {
        self.data = nil
        self.error = CoinbaseProError.networkError
    }

    func setMissingData() {
        self.data = nil
        self.error = CoinbaseProError.dataError
    }

    func pagination(_ headers: [AnyHashable : Any]) -> [String : String]? {
        return nil
    }
}

func JSONData(fromFile fileName: String) -> Data {
    let path = Bundle(for: NetworkMock.self).url(forResource: fileName, withExtension: "json")
    return try! Data(contentsOf: path!)
}
