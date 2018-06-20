//
//  LoggerSpec.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 12/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro

class LoggerSpec: QuickSpec {
    override func spec() {

        describe("init") {

            it("should init with BasicLogger") {
                let logger = Logger()
                expect(logger.output).to(beAnInstanceOf(BasicLogger.self))
            }

            it("should init with log level .debug") {
                let logger = Logger()
                expect(logger.level).to(equal(LogLevel.debug))
            }
        }

        describe("log levels") {

            var mockLogger: MockLogger!
            var logger: Logger!

            beforeEach {
                mockLogger = MockLogger()
                logger = Logger()
                logger.output = mockLogger
            }

            context("verbose") {

                beforeEach {
                    logger.level = .verbose
                }

                it("should log verbose") {
                    logger.verbose("verbose")
                    expect(mockLogger.level).to(equal(LogLevel.verbose))
                    expect(mockLogger.message).to(equal("verbose"))
                }

                it("should log debug") {
                    logger.debug("debug")
                    expect(mockLogger.level).to(equal(LogLevel.debug))
                    expect(mockLogger.message).to(equal("debug"))
                }

                it("should log info") {
                    logger.info("info")
                    expect(mockLogger.level).to(equal(LogLevel.info))
                    expect(mockLogger.message).to(equal("info"))
                }

                it("should log warning") {
                    logger.warning("warning")
                    expect(mockLogger.level).to(equal(LogLevel.warning))
                    expect(mockLogger.message).to(equal("warning"))
                }

                it("should log error") {
                    logger.error("error")
                    expect(mockLogger.level).to(equal(LogLevel.error))
                    expect(mockLogger.message).to(equal("error"))
                }
            }

            context("debug") {

                beforeEach {
                    logger.level = .debug
                }

                it("should not log verbose") {
                    logger.verbose("verbose")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should log debug") {
                    logger.debug("debug")
                    expect(mockLogger.level).to(equal(LogLevel.debug))
                    expect(mockLogger.message).to(equal("debug"))
                }

                it("should log info") {
                    logger.info("info")
                    expect(mockLogger.level).to(equal(LogLevel.info))
                    expect(mockLogger.message).to(equal("info"))
                }

                it("should log warning") {
                    logger.warning("warning")
                    expect(mockLogger.level).to(equal(LogLevel.warning))
                    expect(mockLogger.message).to(equal("warning"))
                }

                it("should log error") {
                    logger.error("error")
                    expect(mockLogger.level).to(equal(LogLevel.error))
                    expect(mockLogger.message).to(equal("error"))
                }
            }

            context("info") {

                beforeEach {
                    logger.level = .info
                }

                it("should not log verbose") {
                    logger.verbose("verbose")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should not log debug") {
                    logger.debug("debug")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should log info") {
                    logger.info("info")
                    expect(mockLogger.level).to(equal(LogLevel.info))
                    expect(mockLogger.message).to(equal("info"))
                }

                it("should log warning") {
                    logger.warning("warning")
                    expect(mockLogger.level).to(equal(LogLevel.warning))
                    expect(mockLogger.message).to(equal("warning"))
                }

                it("should log error") {
                    logger.error("error")
                    expect(mockLogger.level).to(equal(LogLevel.error))
                    expect(mockLogger.message).to(equal("error"))
                }
            }

            context("warning") {

                beforeEach {
                    logger.level = .warning
                }

                it("should not log verbose") {
                    logger.verbose("verbose")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should not log debug") {
                    logger.debug("debug")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should not log info") {
                    logger.info("info")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should log warning") {
                    logger.warning("warning")
                    expect(mockLogger.level).to(equal(LogLevel.warning))
                    expect(mockLogger.message).to(equal("warning"))
                }

                it("should log error") {
                    logger.error("error")
                    expect(mockLogger.level).to(equal(LogLevel.error))
                    expect(mockLogger.message).to(equal("error"))
                }
            }

            context("error") {

                beforeEach {
                    logger.level = .error
                }

                it("should not log verbose") {
                    logger.verbose("verbose")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should not log debug") {
                    logger.debug("debug")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should not log info") {
                    logger.info("info")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should not log warning") {
                    logger.warning("warning")
                    expect(mockLogger.level).to(beNil())
                    expect(mockLogger.message).to(beNil())
                }

                it("should log error") {
                    logger.error("error")
                    expect(mockLogger.level).to(equal(LogLevel.error))
                    expect(mockLogger.message).to(equal("error"))
                }
            }
        }
    }
}
