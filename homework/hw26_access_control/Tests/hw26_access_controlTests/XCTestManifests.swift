import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw26_access_controlTests.allTests),
    ]
}
#endif
