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
    func makeRequest(method: String, requestURL: URL, parameters: [String: String], headers: [String: String], callback: @escaping (CoinbaseProError?, (Data?, Pagination?)) -> Void)
    func pagination(_ headers: [AnyHashable: Any]) -> Pagination?
}

struct Request: Loggable {

    let credentials: APICredentials
    let network: Networkable

    init(withAPIKey key: String, secret: String, phrase: String, baseURL: String? = nil, network: Networkable? = nil) {
        self.credentials = APICredentials(key: key, secret: secret, phrase: phrase, baseURL: baseURL)
        self.network = network ?? NetworkFire()
    }

    func array<T>(model: T.Type, method: String, path: String, parameters: [String: String] = [:], callback: @escaping (CoinbaseProError?, ([T]?, Pagination?)) -> Void) where T: Decodable {
        let signedHeader = credentials.signedHeader(method: method, requestPath: path, parameters: parameters)
        let requestURL = URL(string: path, relativeTo: credentials.baseURL)!
        self.network.makeRequest(method: method, requestURL: requestURL, parameters: parameters, headers: signedHeader) { error, result in
            guard error == nil, let jsonData = result.0 else {
                return callback(error, (nil, nil))
            }
            do {
                let model = try JSONDecoder().decode([T].self, from: jsonData)
                return callback(nil, (model, result.1))
            } catch let parseError {
                self.logger.error("Decodable failure: \(parseError)")
                self.logger.debug(String(data: jsonData, encoding: .utf8) ?? "")
                return callback(.decodeError, (nil, nil))
            }
        }
    }

    func object<T>(model: T.Type, method: String, path: String, parameters: [String: String] = [:], callback: @escaping (CoinbaseProError?, T?) -> Void) where T: Decodable {
        let signedHeader = credentials.signedHeader(method: method, requestPath: path, parameters: parameters)
        let requestURL = URL(string: path, relativeTo: credentials.baseURL)!
        self.network.makeRequest(method: method, requestURL: requestURL, parameters: parameters, headers: signedHeader) { error, result in
            guard error == nil, let jsonData = result.0 else {
                return callback(error, nil)
            }
            do {
                let model = try JSONDecoder().decode(model.self, from: jsonData)
                return callback(nil, model)
            } catch let parseError {
                self.logger.error("Decodable failure: \(parseError)")
                self.logger.debug(String(data: jsonData, encoding: .utf8) ?? "")
                return callback(.decodeError, nil)
            }
        }
    }
}
