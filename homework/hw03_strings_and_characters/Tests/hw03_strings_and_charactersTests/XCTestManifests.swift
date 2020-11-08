import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw03_strings_and_charactersTests.allTests),
    ]
}
#endif
