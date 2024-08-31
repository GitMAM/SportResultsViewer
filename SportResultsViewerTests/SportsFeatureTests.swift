import XCTest
import ComposableArchitecture
@testable import SportResultsViewer

final class SportsFeatureTests: XCTestCase {
  @MainActor
  func testGetResultsButtonTapped() async {
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient = .testValue
      $0.dateFormatter = .testValue
      $0.date.now = Date(timeIntervalSince1970: 1725148800) // 2024-08-31 00:00:00 UTC
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.success(DisplayableSportResult.mocked))) {
      $0.isLoading = false
      $0.sportResults = IdentifiedArrayOf(uniqueElements: DisplayableSportResult.mocked.map { result in
        var formattedResult = result
        formattedResult.formattedPublicationDate = "31 August 2024"
        return formattedResult
      })
      $0.formattedDate = "Results for 2024-08-31"
    }
  }
  
  @MainActor
  func testFetchSportResultsSuccess() async {
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient = .testValue
      $0.dateFormatter = .testValue
      $0.date.now = Date(timeIntervalSince1970: 1725148800) // 2024-08-31 00:00:00 UTC
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.success(DisplayableSportResult.mocked))) {
      $0.isLoading = false
      $0.sportResults = IdentifiedArrayOf(uniqueElements: DisplayableSportResult.mocked.map { result in
        var formattedResult = result
        formattedResult.formattedPublicationDate = "31 August 2024"
        return formattedResult
      })
      $0.formattedDate = "Results for 2024-08-31"
    }
  }
  
  @MainActor
  func testFetchSportResultsFailure() async {
    let expectedError = NSError(domain: "Test", code: 0, userInfo: nil)
    
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient.fetchSportResults = { throw expectedError }
      $0.dateFormatter = .testValue
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.failure(expectedError))) {
      $0.isLoading = false
      $0.error = expectedError.localizedDescription
    }
  }
  
  @MainActor
  func testSportResultsResponseSuccessWithEmptyResults() async {
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient.fetchSportResults = { [] }
      $0.dateFormatter = .testValue
      $0.date.now = Date(timeIntervalSince1970: 1725148800) // 2024-08-31 00:00:00 UTC
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.success([]))) {
      $0.isLoading = false
      $0.sportResults = []
      $0.formattedDate = "Results for 2024-08-31"
    }
  }
  
  func testInitialState() {
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    }
    
    XCTAssertTrue(store.state.sportResults.isEmpty)
    XCTAssertFalse(store.state.isLoading)
    XCTAssertNil(store.state.error)
    XCTAssertNil(store.state.formattedDate)
  }
  
  @MainActor
  func testFetchSportResultsNetworkError() async {
    let expectedError = NSError(domain: "Network", code: 0, userInfo: nil)
    
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient.fetchSportResults = { throw expectedError }
      $0.dateFormatter = .testValue
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.failure(expectedError))) {
      $0.isLoading = false
      $0.error = expectedError.localizedDescription
    }
  }
  
  @MainActor
  func testFetchSportResultsDecodingError() async {
    let expectedError = NSError(domain: "Decoding", code: 0, userInfo: nil)
    
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient.fetchSportResults = { throw expectedError }
      $0.dateFormatter = .testValue
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.failure(expectedError))) {
      $0.isLoading = false
      $0.error = expectedError.localizedDescription
    }
  }
  
  @MainActor
  func testFetchSportResultsEmptyResponse() async {
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient.fetchSportResults = { [] }
      $0.dateFormatter = .testValue
      $0.date.now = Date(timeIntervalSince1970: 1725148800) // 2024-08-31 00:00:00 UTC
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.success([]))) {
      $0.isLoading = false
      $0.sportResults = []
      $0.formattedDate = "Results for 2024-08-31"
    }
  }
  
  @MainActor
  func testGetResultsButtonTappedTwice() async {
    let store = TestStore(initialState: SportsFeature.State()) {
      SportsFeature()
    } withDependencies: {
      $0.sportsClient.fetchSportResults = { DisplayableSportResult.mocked }
      $0.dateFormatter = .testValue
      $0.date.now = Date(timeIntervalSince1970: 1725148800) // 2024-08-31 00:00:00 UTC
    }
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.success(DisplayableSportResult.mocked))) {
      $0.isLoading = false
      $0.sportResults = IdentifiedArrayOf(uniqueElements: DisplayableSportResult.mocked.map { result in
        var formattedResult = result
        formattedResult.formattedPublicationDate = "31 August 2024"
        return formattedResult
      })
      $0.formattedDate = "Results for 2024-08-31"
    }
    
    // Change the mock results for the second fetch
    let newMockResults = [
      DisplayableSportResult(publicationDate: Date(timeIntervalSince1970: 1725235200), description: "New F1 Winner wins New F1 GP by 6.0 seconds", formattedPublicationDate: "31 August 2024")
    ]
    store.dependencies.sportsClient.fetchSportResults = { newMockResults }
    store.dependencies.date.now = Date(timeIntervalSince1970: 1725235200) // 2024-09-01 00:00:00 UTC
    
    await store.send(.getResultsButtonTapped) {
      $0.isLoading = true
      $0.error = nil
      $0.sportResults = []
      $0.formattedDate = nil
    }
    
    await store.receive(.sportResultsResponse(.success(newMockResults))) {
      $0.isLoading = false
      $0.sportResults = IdentifiedArrayOf(uniqueElements: newMockResults)
      $0.formattedDate = "Results for 2024-08-31"
    }
  }
}
