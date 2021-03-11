import XCTest

import simpleLoggingTests

var tests = [XCTestCaseEntry]()
tests += simpleLoggingTests.allTests()
XCTMain(tests)
