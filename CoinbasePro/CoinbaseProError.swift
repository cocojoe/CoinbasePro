//
//  CoinbaseProError.swift
//  CoinbasePro
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

/// CoinbaseProErrors
///
/// - networkError: Something went wrong during the network request
/// - dataError: Something went wrong during data decoding
public enum CoinbaseProError: Error {
    case networkError
    case dataError
    case decodeError
}
