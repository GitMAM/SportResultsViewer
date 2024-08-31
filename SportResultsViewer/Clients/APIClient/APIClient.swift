import ComposableArchitecture
import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

@DependencyClient
struct APIClient {
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

