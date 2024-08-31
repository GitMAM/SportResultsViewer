import ComposableArchitecture
import Foundation

@DependencyClient
struct DisplayableSportResultClient {
  var transform: @Sendable ([SportResult]) async throws -> [DisplayableSportResult]
  var filterSameDay: @Sendable ([DisplayableSportResult]) async throws -> [DisplayableSportResult]
}


// MARK: - DisplayableSportResultClient TestDependency
extension DisplayableSportResultClient: TestDependencyKey {
  static let previewValue = Self(
    transform: { _ in [] },
    filterSameDay: { $0 }
  )
  
  static var testValue: DisplayableSportResultClient {
    let mockResults = [DisplayableSportResult.mock, DisplayableSportResult.mock]
    
    return Self(
      transform: { _ in mockResults },
      filterSameDay: { results in
        // By default, return all results as if they're from the same day
        results
      }
    )
  }
}

extension DependencyValues {
  var displayableSportResultClient: DisplayableSportResultClient {
    get { self[DisplayableSportResultClient.self] }
    set { self[DisplayableSportResultClient.self] = newValue }
  }
}

extension DisplayableSportResult {
  static let mock = DisplayableSportResult(
    publicationDate: Date(timeIntervalSince1970: 1640995200),
    description: "Mock Sport Result"
  )
}
