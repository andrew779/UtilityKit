import XCTest
@testable import UtilityKit

final class UtilityKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(UtilityKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
