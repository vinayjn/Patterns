import XCTest
@testable import Patterns

final class PatternsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Patterns().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
