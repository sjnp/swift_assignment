import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw09_structures_and_classesTests.allTests),
    ]
}
#endif
