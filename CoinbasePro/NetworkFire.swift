//
//  NetworkFire.swift
//  CoinbasePro
//
//  Created by Martin on 09/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Alamofire

public struct NetworkFire: Loggable, Networkable {

    let sessionManager: SessionManager

    public init(withSessionManager manager: SessionManager? = nil) {
        self.sessionManager = manager ??  Alamofire.SessionManager.default
    }

    public func makeRequest(method: String, requestURL: URL, parameters: [String: String], headers: [String: String], callback: @escaping (CoinbaseProError?, Data?) -> Void) {
        self.logger.verbose("request: \(requestURL.absoluteString)")
        sessionManager.request(requestURL, method: HTTPMethod(rawValue: method)!, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    return callback(nil, response.data)
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
