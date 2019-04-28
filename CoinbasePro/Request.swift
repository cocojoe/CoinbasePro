//
//  Request.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 06/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

/// Networkable
/// Adpot this protocol if you want to create your own network object for handling API requests
public protocol Networkable {
    // swiftlint:disable:next function_parameter_count
    func makeRequest(method: String, requestURL: URL, body: String?, parameters: [String: String], headers: [String: String], callback: @escaping (CoinbaseProError?, (Data?, Pagination?)) -> Void)
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
        let body = method == "POST" ? generateBody(withParameters: parameters) : nil
        let signedHeader = credentials.signedHeader(method: method, requestPath: path, body: body, parameters: parameters)
        let requestURL = URL(string: path, relativeTo: credentials.baseURL)!
        self.network.makeRequest(method: method, requestURL: requestURL, body: body, parameters: parameters, headers: signedHeader) { error, result in
            guard error == nil, let jsonData = result.0 else {
                return callback(error, (nil, nil))
            }
            do {
                let model = try JSONDecoder()
                    .caseDecoder()
                    .decode([T].self, from: jsonData)
                return callback(nil, (model, result.1))
            } catch let parseError {
                self.logger.error("Decodable failure: \(parseError)")
                return callback(.decodeError, (nil, nil))
            }
        }
    }

    func object<T>(model: T.Type, method: String, path: String, parameters: [String: String] = [:], callback: @escaping (CoinbaseProError?, T?) -> Void) where T: Decodable {
        let body = method == "POST" ? generateBody(withParameters: parameters) : nil
        let signedHeader = credentials.signedHeader(method: method, requestPath: path, body: body, parameters: parameters)
        let requestURL = URL(string: path, relativeTo: credentials.baseURL)!
        self.network.makeRequest(method: method, requestURL: requestURL, body: body, parameters: parameters, headers: signedHeader) { error, result in
            guard error == nil, let jsonData = result.0 else {
                return callback(error, nil)
            }
            do {
                let model = try JSONDecoder()
                    .caseDecoder()
                    .decode(model.self, from: jsonData)
                return callback(nil, model)
            } catch let parseError {
                self.logger.error("Decodable failure: \(parseError)")
                return callback(.decodeError, nil)
            }
        }
    }

    func generateBody(withParameters parameters: [String: String]) -> String {
        // JSON encoded output has to be identical between signature generation and body post.
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        return String(data: jsonData!, encoding: String.Encoding.ascii)!
    }
}
