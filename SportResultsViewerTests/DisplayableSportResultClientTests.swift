import XCTest
@testable import  SportResultsViewer
import Dependencies
// Create an array of SportResult objects for testing
let mockSportResults: [any SportResult] = [
  F1Result.mock,
  NBAResult.mock,
  TennisResult.mock
]

// MARK: - DisplayableSportResultClientTests
final class DisplayableSportResultClientTests: XCTestCase {
  func testTransformSuccess() async throws {
    let client = DisplayableSportResultClient.testValue
    
    do {
      let displayableResults = try await client.transform(mockSportResults)
      XCTAssertEqual(displayableResults.count, 2)
      XCTAssertEqual(displayableResults.first?.description, "Mock Sport Result")
    } catch {
      XCTFail("Expected successful transformation, but got error: \(error)")
    }
  }
  
  func testFilterSameDaySuccess() async throws {
    let client = DisplayableSportResultClient.testValue
    
    do {
      let transformedResults = try await client.transform(mockSportResults)
      let filteredResults = try await client.filterSameDay(transformedResults)
      XCTAssertEqual(filteredResults.count, 2) // As defined in testValue
    } catch {
      XCTFail("Expected successful filtering, but got error: \(error)")
    }
  }
  
  func testCustomTransformAndFilter() async throws {
    let today = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
    
    let client = DisplayableSportResultClient(
      transform: { sportResults in
        sportResults.map { result in
          DisplayableSportResult(
            publicationDate: result.publicationDate,
            description: result.resultDescription
          )
        }
      },
      filterSameDay: { results in
        results.filter { Calendar.current.isDate($0.publicationDate, inSameDayAs: today) }
      }
    )
    
    let customMockResults: [any SportResult] = [
      F1Result(publicationDate: today, seconds: 1.234, tournament: "Today's Race", winner: "Today's Winner"),
      NBAResult(gameNumber: 1, loser: "Team B", mvp: "Player A", publicationDate: yesterday, tournament: "Yesterday's Game", winner: "Team A")
    ]
    
    do {
      let transformedResults = try await client.transform(customMockResults)
      XCTAssertEqual(transformedResults.count, 2)
      
      let filteredResults = try await client.filterSameDay(transformedResults)
      XCTAssertEqual(filteredResults.count, 1)
      XCTAssertTrue(filteredResults.first?.description.contains("Today's Race") ?? false)
    } catch {
      XCTFail("Expected successful custom transform and filter, but got error: \(error)")
    }
  }
}
