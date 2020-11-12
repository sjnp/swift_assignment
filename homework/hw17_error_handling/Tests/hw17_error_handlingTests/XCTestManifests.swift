import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw17_error_handlingTests.allTests),
    ]
}
#endif
