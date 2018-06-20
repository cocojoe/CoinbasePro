//
//  Logger.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 09/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

class Logger {

    private(set) static var sharedInstance = Logger()

    var level: LogLevel = .debug
    var output: LoggerType = BasicLogger()

    func verbose(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.hashValue >= LogLevel.verbose.hashValue else { return }
        output.message(message, level: .verbose, filename: filename, line: line)
    }

    func debug(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.hashValue >= LogLevel.debug.hashValue else { return }
        output.message(message, level: .debug, filename: filename, line: line)
    }

    func info(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.hashValue >= LogLevel.info.hashValue else { return }
        output.message(message, level: .info, filename: filename, line: line)
    }

    func error(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.hashValue >= LogLevel.error.hashValue else { return }
        output.message(message, level: .error, filename: filename, line: line)
    }

    func warning(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level.hashValue >= LogLevel.warning.hashValue else { return }
        output.message(message, level: .warning, filename: filename, line: line)
    }
}

public enum LogLevel: String {
    case error = "Error"
    case warning = "Warning"
    case info = "Info"
    case debug = "Debug"
    case verbose = "Verbose"
}
