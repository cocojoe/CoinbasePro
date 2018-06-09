//
//  Network.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Alamofire

struct Network: Loggable {

    private let credentials: APICredentials

    init(withAPIKey key: String, secret: String, phrase: String, baseURL: String?) {
        self.credentials = APICredentials(key: key, secret: secret, phrase: phrase, baseURL: baseURL)
    }

    func requestArray<T>(model: T.Type, method: String, path: String, parameters: [String: String] = [:], callback: @escaping (CoinbaseProError?, [T]?) -> Void) where T: Decodable {
        self.makeRequest(method: method, path: path, parameters: parameters) { error, jsonData in
            guard error == nil, let jsonData = jsonData else {
                return callback(error, nil)
            }
            do {
                let result = try JSONDecoder().decode(Array<T>.self, from: jsonData)
                return callback(nil, result)
            } catch let parseError {
                self.logger.error("JSON parsing failed: \(parseError)")
                return callback(.dataError, nil)
            }
        }
    }

    func request<T>(model: T.Type, method: String, path: String, parameters: [String: String] = [:], callback: @escaping (CoinbaseProError?, T?) -> Void) where T: Decodable {
        self.makeRequest(method: method, path: path, parameters: parameters) { error, jsonData in
            guard error == nil, let jsonData = jsonData else {
                return callback(error, nil)
            }
            do {
                let result = try JSONDecoder().decode(APIError.self, from: jsonData)
                return callback(nil, result as? T)
            } catch let parseError {
                self.logger.error("JSON parsing failed: \(parseError)")
                return callback(.dataError, nil)
            }
        }
    }

    private func makeRequest(method: String, path: String, parameters: [String: String], callback: @escaping (CoinbaseProError?, Data?) -> Void) {
        let requestURL = URL(string: path, relativeTo: credentials.baseURL)!
        self.logger.verbose("request: \(requestURL.absoluteString)")
        Alamofire.request(requestURL, method: HTTPMethod(rawValue: method)!, parameters: parameters, headers: credentials.signMessage(method: method, requestPath: path))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let jsonData = response.data else {
                        self.logger.error("JSON parsing failed")
                        return callback(.dataError, nil)
                    }
                    return callback(nil, jsonData)
                case .failure(let error):
                    if  let errorData = response.data,
                        let errorInfo = try? JSONDecoder().decode(APIError.self, from: errorData) {
                        self.logger.error("Request failed: \(errorInfo.description)")
                        return callback(.networkError, nil)
                    } else {
                        self.logger.error("Request failed: \(error.localizedDescription)")
                        return callback(.networkError, nil)
                    }
                }
        }
    }
}
