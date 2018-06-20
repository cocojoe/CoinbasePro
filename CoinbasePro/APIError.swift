//
//  APIError.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 09/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

struct APIError {

    let description: String

    init(description: String) {
        self.description = description
    }
}

extension APIError: Decodable {
    enum CodingKeys: String, CodingKey {
        case description = "message"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let description: String = try container.decode(String.self, forKey: .description)
        self.init(description: description)
    }
}
