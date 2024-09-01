import ComposableArchitecture
import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

/// A client for making API requests to fetch sports results data.
///
/// This client handles the low-level networking details and JSON decoding.
@DependencyClient
struct APIClient {
  /// Fetches raw sports results data from the API.
  ///
  /// - Returns: A `SportResults` object containing the fetched data.
  /// - Throws: An error if the network request fails or if the response cannot be decoded.
  var fetchSportsResults: @Sendable () async throws -> SportResults
}

extension APIClient: TestDependencyKey {
  static var testValue: APIClient {
    APIClient(
      fetchSportsResults: {
        SportResults(
          f1Results: [F1Result.mock],
          nbaResults: [NBAResult.mock],
          tennis: [TennisResult.mock]
        )
      }
    )
  }
}

extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}

