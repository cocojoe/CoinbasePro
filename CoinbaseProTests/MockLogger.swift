//
//  MockLogger.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 12/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation
@testable import CoinbasePro

class MockLogger: LoggerType {

    var level: LogLevel?
    var message: String?

    func message(_ message: String, level: LogLevel, filename: String, line: Int) {
        self.level = level
        self.message = message
    }
}
