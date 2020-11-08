import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw10_propertiesTests.allTests),
    ]
}
#endif
