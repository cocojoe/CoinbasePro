//
//  SimpleModel.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 11/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

public struct SimpleModel {

    public let id: String

    init(id: String) {
        self.id = id
    }
}

extension SimpleModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        self.init(id: id)
    }
}
