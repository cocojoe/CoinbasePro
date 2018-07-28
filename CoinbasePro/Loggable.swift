//
//  Loggable.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 12/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

protocol Loggable { }

extension Loggable {
    var logger: Logger {
        return Logger.sharedInstance
    }
}
