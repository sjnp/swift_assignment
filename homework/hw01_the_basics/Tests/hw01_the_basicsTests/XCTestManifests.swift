import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw01_the_basicsTests.allTests),
    ]
}
#endif
