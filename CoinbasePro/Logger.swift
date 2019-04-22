//
//  Logger.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 09/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

class Logger {

    static let sharedInstance = Logger()

    var level: LogLevel = .debug
    var output: LoggerType = BasicLogger()

    func verbose(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.rawValue >= LogLevel.verbose.rawValue else { return }
        output.message(message, level: .verbose, filename: filename, line: line)
    }

    func debug(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.rawValue >= LogLevel.debug.rawValue else { return }
        output.message(message, level: .debug, filename: filename, line: line)
    }

    func info(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.rawValue >= LogLevel.info.rawValue else { return }
        output.message(message, level: .info, filename: filename, line: line)
    }

    func warning(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.rawValue >= LogLevel.warning.rawValue else { return }
        output.message(message, level: .warning, filename: filename, line: line)
    }

    func error(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.rawValue >= LogLevel.error.rawValue else { return }
        output.message(message, level: .error, filename: filename, line: line)
    }
}

public enum LogLevel: Int {
    case error = 0
    case warning = 1
    case info = 2
    case debug = 3
    case verbose = 4
}
