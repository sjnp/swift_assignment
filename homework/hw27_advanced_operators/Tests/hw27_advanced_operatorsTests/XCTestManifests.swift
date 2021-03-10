import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw27_advanced_operatorsTests.allTests),
    ]
}
#endif
