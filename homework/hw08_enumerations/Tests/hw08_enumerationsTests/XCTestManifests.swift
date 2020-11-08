import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw08_enumerationsTests.allTests),
    ]
}
#endif
