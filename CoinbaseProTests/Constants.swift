//
//  Constants.swift
//  CoinbaseProTests
//
//  Created by Martin on 11/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

struct Constants {
    static let APIKey = "APIKEY123"
    static let APISecret = "QVBJU0VDUkVUMTIz"
    static let APIPhrase = "APIPHRASE123"
    static let Timeout = 2.0
    
    static let JSONSimpleArray = "request-array-simple"
    static let JSONSimpleObject = "request-object-simple"
    static let JSONAPIErrorObject = "request-object-apierror"

    struct Accounts {
        static let JSONArray = "request-array-account"
        static let JSONObject = "request-object-account"
        static let JSONHistoryArray = "request-array-account-history"
        static let JSONHoldArray = "request-array-account-hold"
    }
}
