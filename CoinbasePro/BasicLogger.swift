//
//  BasicLogger.swift
//  CoinbasePro
//
//  Created by Martin on 12/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

public protocol LoggerType {
    func message(_ message: String, level: LogLevel, filename: String, line: Int)
}

struct BasicLogger: LoggerType {

    var trace: (String, LogLevel, String) -> Void = { print("\($1.rawValue) | \($0) - \($2)") }

    func message(_ message: String, level: LogLevel, filename: String, line: Int) {
        trace("\(heading(forFile: filename, line: line))", level, message)
    }

    private func heading(forFile file: String, line: Int) -> String {
        let filename = URL(fileURLWithPath: file).lastPathComponent
        return "\(filename):\(line)"
    }
}
