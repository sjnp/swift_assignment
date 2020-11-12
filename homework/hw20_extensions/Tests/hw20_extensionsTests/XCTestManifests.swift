import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw20_extensionsTests.allTests),
    ]
}
#endif
