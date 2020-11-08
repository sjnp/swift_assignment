import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw04_collection_typesTests.allTests),
    ]
}
#endif
