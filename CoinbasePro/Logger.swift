//
//  Logger.swift
//  CoinbasePro
//
//  Created by Martin on 09/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

public class Logger {

    static let sharedInstance = Logger()

    var level: LoggerLevel = .all
    var output: LoggerOutput = DefaultLoggerOutput()

    func debug(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level >= .debug else { return }
        output.message(message, level: .debug, filename: filename, line: line)
    }

    func info(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level >= .info else { return }
        output.message(message, level: .info, filename: filename, line: line)
    }

    func error(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level >= .error else { return }
        output.message(message, level: .error, filename: filename, line: line)
    }

    func warn(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level >= .warn else { return }
        output.message(message, level: .warn, filename: filename, line: line)
    }

    func verbose(_ message: String, filename: String = #file, line: Int = #line) {
        guard self.level >= .verbose else { return }
        output.message(message, level: .verbose, filename: filename, line: line)
    }
}

public enum LoggerLevel: Int {
    case off = 0, error, warn, info, debug, verbose, all

    var label: String {
        switch self {
        case .error:
            return "ERROR"
        case .warn:
            return "WARN"
        case .info:
            return "INFO"
        case .debug:
            return "DEBUG"
        case .verbose:
            return "VERBOSE"
        default:
            return "INVALID"
        }
    }
}

func >= (lhs: LoggerLevel, rhs: LoggerLevel) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}

// MARK: - Loggable

protocol Loggable { }

extension Loggable {
    var logger: Logger {
        return Logger.sharedInstance
    }
}

// MARK: - LoggerOutput

public protocol LoggerOutput {
    func message(_ message: String, level: LoggerLevel, filename: String, line: Int)
}

struct DefaultLoggerOutput: LoggerOutput {

    var trace: (String, LoggerLevel, String) -> Void = { print("\($1.label) | \($0) - \($2)") }

    func message(_ message: String, level: LoggerLevel, filename: String, line: Int) {
        trace("\(heading(forFile: filename, line: line))", level, message)
    }

    private func heading(forFile file: String, line: Int) -> String {
        let filename = URL(fileURLWithPath: file).lastPathComponent
        return "\(filename):\(line)"
    }
}
