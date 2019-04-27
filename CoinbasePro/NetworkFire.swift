//
//  NetworkFire.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 09/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Alamofire

struct NetworkFire: Loggable, Networkable {

    func makeRequest(method: String, requestURL: URL, parameters: [String: String], headers: [String: String], callback: @escaping (CoinbaseProError?, (Data?, Pagination?)) -> Void) {
        self.logger.debug("request: \(requestURL.absoluteString), parameters: \(parameters)")
        Alamofire.request(requestURL, method: HTTPMethod(rawValue: method)!, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    var pagination: Pagination?
                    if let headers = response.response?.allHeaderFields {
                        pagination = self.pagination(headers)
                    }
                    return callback(nil, (response.data, pagination))
                case .failure(let error):
                    if  let errorData = response.data,
                        let errorInfo = try? JSONDecoder()
                            .caseDecoder()
                            .decode(APIError.self, from: errorData) {
                        self.logger.error("Request failed: \(errorInfo.description)")
                        return callback(.networkError, (nil, nil))
                    } else {
                        self.logger.error("Request failed: \(error.localizedDescription)")
                        return callback(.networkError, (nil, nil))
                    }
                }
        }
    }

    func pagination(_ headers: [AnyHashable: Any]) -> Pagination? {
        let next =  headers["cb-after"] as? String
        let previous = headers["cb-before"] as? String
        return Pagination(next: next, previous: previous)
    }
}
