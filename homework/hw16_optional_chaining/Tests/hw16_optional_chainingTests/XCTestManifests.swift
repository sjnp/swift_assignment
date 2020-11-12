import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw16_optional_chainingTests.allTests),
    ]
}
#endif
