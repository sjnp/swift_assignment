import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw25_memory_safetyTests.allTests),
    ]
}
#endif
