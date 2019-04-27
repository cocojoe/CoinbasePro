//
//  NetworkFire.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 09/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Alamofire

struct NetworkFire: Loggable, Networkable {

    func makeRequest(method: String, requestURL: URL, body: String? = nil, parameters: [String: String], headers: [String: String], callback: @escaping (CoinbaseProError?, (Data?, Pagination?)) -> Void) {
        self.logger.debug("request: \(requestURL.absoluteString), method: \(method), parameters: \(parameters), body: \(body ?? "")")

        // Have to create POST due to body value consistency requirement
        var request: DataRequest
        if method == "POST", let body = body {
            var urlRequest = URLRequest(url: requestURL)
            urlRequest.httpMethod = method
            urlRequest.httpBody = body.data(using: .utf8)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            headers.forEach {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
            request = Alamofire.request(urlRequest)
        } else {
            request = Alamofire.request(requestURL, method: HTTPMethod(rawValue: method)!, parameters: parameters, headers: headers)
        }

        request
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                self.logger.debug(response.timeline.description)
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
                        self.logger.error("Request failed: \(errorInfo.message)")
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
