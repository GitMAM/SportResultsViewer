import ComposableArchitecture
import Foundation

// MARK: - DisplayableSportResultClient Live Implementation
/// The DisplayableSportResultClient serves two main purposes:
/// 1. It transforms raw sport results into a displayable format.
/// 2. It filters results to show only those from the same day. (as per requirements)
///
/// This separation allows for reuse of transformation logic across different
/// parts of the app and keeps data fetching distinct from data processing.
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
