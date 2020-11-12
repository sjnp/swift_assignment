import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw15_deinitializationTests.allTests),
    ]
}
#endif
