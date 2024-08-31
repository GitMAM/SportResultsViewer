import Foundation
import ComposableArchitecture

// MARK: - SportsClient Dependency
/// A client for fetching and transforming sports results data.
@DependencyClient
struct SportsClient {
  var fetchSportResults: @Sendable () async throws -> [DisplayableSportResult]
}

// MARK: - SportsClient TestDependency
extension SportsClient: TestDependencyKey {
  static let previewValue = Self(
    fetchSportResults: {
      [
        DisplayableSportResult(publicationDate: Date(), description: "Roland Garros: Rafael Nadal wins against Schwartzman in 3 sets"),
        DisplayableSportResult(publicationDate: Date(), description: "Lewis Hamilton wins Silverstone Grand Prix by 5.856 seconds"),
        DisplayableSportResult(publicationDate: Date(), description: "Lebron James leads Lakers to game 4 win in the NBA playoffs")
      ]
    }
  )
  
  static let testValue = Self(
    fetchSportResults: {
      DisplayableSportResult.mocked
    }
  )
}

extension DependencyValues {
  var sportsClient: SportsClient {
    get { self[SportsClient.self] }
    set { self[SportsClient.self] = newValue }
  }
}


extension DisplayableSportResult {
  static let mocked = [
    DisplayableSportResult(
      publicationDate: Date(timeIntervalSince1970: 1641081600),
      description: "Mock Sport Result 1",
      formattedPublicationDate: "2 January 2022"
    ),
    DisplayableSportResult(
      publicationDate: Date(timeIntervalSince1970: 1640995200),
      description: "Mock Sport Result 2",
      formattedPublicationDate: "1 January 2022"
    )
  ]
}
