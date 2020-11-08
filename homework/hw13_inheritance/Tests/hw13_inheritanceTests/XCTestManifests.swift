import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw13_inheritanceTests.allTests),
    ]
}
#endif
