import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw19_nested_typesTests.allTests),
    ]
}
#endif
