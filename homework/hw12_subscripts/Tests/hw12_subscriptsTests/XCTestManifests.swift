import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw12_subscriptsTests.allTests),
    ]
}
#endif
