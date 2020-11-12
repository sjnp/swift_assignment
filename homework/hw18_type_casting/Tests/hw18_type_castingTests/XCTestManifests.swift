import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(hw18_type_castingTests.allTests),
    ]
}
#endif
