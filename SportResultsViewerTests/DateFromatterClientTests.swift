import XCTest
import Dependencies
@testable import SportResultsViewer


final class DateFormatterClientTests: XCTestCase {
  var client: DateFormatterClient!
  
  override func setUp() {
    super.setUp()
    client = DateFormatterClient.liveValue
  }
  
  func testValidDateString() throws {
    let date = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
    let result = try client.string(date)
    XCTAssertEqual(result, "2021-01-01")
  }
  
  func testValidDateItemString() throws {
    let date = Date(timeIntervalSince1970: 1609459200) // 2021-01-01
    let result = try client.itemString(date)
    XCTAssertEqual(result, "1 January 2021")
  }
  
  func testInvalidDateString() {
    let invalidDate = Date(timeIntervalSince1970: -62135769601) // One second before the minimum valid date
    XCTAssertThrowsError(try client.string(invalidDate)) { error in
      XCTAssertTrue(error is DateFormatterError)
      XCTAssertEqual(error as? DateFormatterError, .invalidDate)
    }
  }
  
  func testInvalidDateItemString() {
    let invalidDate = Date(timeIntervalSince1970: -62135769601) // One second before the minimum valid date
    XCTAssertThrowsError(try client.itemString(invalidDate)) { error in
      XCTAssertTrue(error is DateFormatterError)
      XCTAssertEqual(error as? DateFormatterError, .invalidDate)
    }
  }
}
