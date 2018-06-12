//
//  Request.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

/// Networkable
/// Adpot this protocol if you want to create your own network object for handling API requests
public protocol Networkable {
    func makeRequest(method: String, requestURL: URL, parameters: [String: String], headers: [String: String], callback: @escaping (CoinbaseProError?, Data?) -> Void)
}

struct Request: Loggable {

    let credentials: APICredentials
    let network: Networkable

    init(withAPIKey key: String, secret: String, phrase: String, baseURL: String? = nil, network: Networkable? = nil) {
        self.credentials = APICredentials(key: key, secret: secret, phrase: phrase, baseURL: baseURL)
        self.network = network ?? NetworkFire()
    }

    func array<T>(model: T.Type, method: String, path: String, parameters: [String: String] = [:], callback: @escaping (CoinbaseProError?, [T]?) -> Void) where T: Decodable {
        let signedHeader = credentials.signedHeader(method: method, requestPath: path)
        let requestURL = URL(string: path, relativeTo: credentials.baseURL)!
        self.network.makeRequest(method: method, requestURL: requestURL, parameters: parameters, headers: signedHeader) { error, jsonData in
            guard error == nil, let jsonData = jsonData else {
                return callback(error, nil)
            }
            do {
                let result = try JSONDecoder().decode([T].self, from: jsonData)
                return callback(nil, result)
            } catch let parseError {
                self.logger.error("JSON parsing failed: \(parseError)")
                return callback(.decodeError, nil)
            }
        }
    }

    func object<T>(model: T.Type, method: String, path: String, parameters: [String: String] = [:], callback: @escaping (CoinbaseProError?, T?) -> Void) where T: Decodable {
        let signedHeader = credentials.signedHeader(method: method, requestPath: path)
        let requestURL = URL(string: path, relativeTo: credentials.baseURL)!
        self.network.makeRequest(method: method, requestURL: requestURL, parameters: parameters, headers: signedHeader) { error, jsonData in
            guard error == nil, let jsonData = jsonData else {
                return callback(error, nil)
            }
            do {
                let result = try JSONDecoder().decode(model.self, from: jsonData)
                return callback(nil, result)
            } catch let parseError {
                self.logger.error("JSON parsing failed: \(parseError)")
                return callback(.decodeError, nil)
            }
        }
    }
}
