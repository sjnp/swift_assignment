import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw05_control_flowTests.allTests),
    ]
}
#endif
