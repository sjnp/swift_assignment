import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw02_basic_operatorsTests.allTests),
    ]
}
#endif
