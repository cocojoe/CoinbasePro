//
//  APIError.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 09/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

struct APIError {

    let message: String
}

extension APIError: Decodable { }
