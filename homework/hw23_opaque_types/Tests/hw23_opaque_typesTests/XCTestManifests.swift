import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw23_opaque_typesTests.allTests),
    ]
}
#endif
