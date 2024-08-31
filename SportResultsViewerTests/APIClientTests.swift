import XCTest
@testable import SportResultsViewer
import Dependencies

final class APIClientTests: XCTestCase {
  func testFetchSportsResultsSuccess() async throws {
    let client = APIClient.testValue
    
    do {
      let results = try await client.fetchSportsResults()
      XCTAssertEqual(results.f1Results.count, 1)
      XCTAssertEqual(results.nbaResults.count, 1)
      XCTAssertEqual(results.tennis.count, 1)
      XCTAssertEqual(results.f1Results.first?.tournament, "Monaco Grand Prix")
      XCTAssertEqual(results.nbaResults.first?.tournament, "NBA Finals")
      XCTAssertEqual(results.tennis.first?.tournament, "Wimbledon")
    } catch {
      XCTFail("Expected successful fetch, but got error: \(error)")
    }
  }
  
  func testAPIClientAndDisplayableClientIntegration() async throws {
    let apiClient = APIClient.testValue
    
    let displayableClient = DisplayableSportResultClient.testValue
    
    do {
      let sportResults = try await apiClient.fetchSportsResults()
      let allResults: [any SportResult] = sportResults.f1Results + sportResults.nbaResults + sportResults.tennis
      let displayableResults = try await displayableClient.transform(allResults)
      let filteredResults = try await displayableClient.filterSameDay(displayableResults)
      
      XCTAssertEqual(filteredResults.count, 2) // As defined in DisplayableSportResultClient.testValue
      XCTAssertEqual(filteredResults.first?.description, "Mock Sport Result")
    } catch {
      XCTFail("Expected successful integration, but got error: \(error)")
    }
  }
}
