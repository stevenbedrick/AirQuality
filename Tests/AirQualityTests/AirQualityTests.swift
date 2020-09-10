import XCTest
@testable import AirQuality

final class AirQualityTests: XCTestCase {
    
    
    func testSuccessfulCompute() {
        
        let someVal = AirQualityIndex.compute(forPollutant: .PM_25, atConcentration: 37.0)
        
        if case .success(let (aqi, c)) = someVal {
            XCTAssertEqual(aqi, 105)
            XCTAssertEqual(c, .UnhealthySensitive)
        } else {
            XCTFail("Bad AQI result")
        }
        
    }
    
    func testErrorCompute() {
        let anotherVal = AirQualityIndex.compute(forPollutant: .PM_25, atConcentration: 600.0)
        if case .failure(let e) = anotherVal {
            XCTAssertEqual(e, .ConcentrationOutOfRange)
        } else {
            XCTFail("Should have gotten error, since input was out of range")
        }

    }

    static var allTests = [
        ("testSuccessfulCompute", testSuccessfulCompute),
        ("testErrorCompute", testErrorCompute)
    ]
}
