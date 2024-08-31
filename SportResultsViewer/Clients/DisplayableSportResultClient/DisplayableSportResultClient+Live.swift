import ComposableArchitecture
import Foundation

// MARK: - DisplayableSportResultClient Live Implementation
extension DisplayableSportResultClient: DependencyKey {
  static var liveValue: DisplayableSportResultClient {
    @Dependency(\.calendar) var calendar
    
    return Self(transform: { sportResults in
      sportResults.map { result in
        DisplayableSportResult(
          publicationDate: result.publicationDate,
          description: result.resultDescription
        )
      }.sorted()
    },filterSameDay: { results in
      guard let mostRecentDate = results.first?.publicationDate else { return [] }
      return results.filter { result in
        calendar.isDate(result.publicationDate, inSameDayAs: mostRecentDate)
      }
    }
    )
  }
}
