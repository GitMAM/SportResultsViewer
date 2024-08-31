import ComposableArchitecture
import Foundation

extension SportsClient: DependencyKey {
  static let liveValue: SportsClient = {
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.displayableSportResultClient) var displayableResultClient
    
    return SportsClient(
      fetchSportResults: {
        let sportResults: SportResults = try await apiClient.fetchSportsResults()
        let allResults: [SportResult] = sportResults.f1Results + sportResults.nbaResults + sportResults.tennis
        let transformedResults = try await displayableResultClient.transform(allResults)
        return try await displayableResultClient.filterSameDay(transformedResults)
      }
    )
  }()
}
