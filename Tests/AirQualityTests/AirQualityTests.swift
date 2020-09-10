import XCTest
@testable import AirQuality

final class AirQualityTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AirQuality().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
