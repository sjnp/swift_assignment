import XCTest

import simpleHTTPServerTests

var tests = [XCTestCaseEntry]()
tests += simpleHTTPServerTests.allTests()
XCTMain(tests)
