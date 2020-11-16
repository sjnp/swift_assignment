import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw24_automatic_referenceTests.allTests),
    ]
}
#endif
