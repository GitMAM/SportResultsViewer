import ComposableArchitecture
import Foundation

/// A client for transforming raw sports results into displayable format.
///
/// This client handles the business logic of converting API data into a format suitable for display in the UI.
@DependencyClient
struct DisplayableSportResultClient {
  /// Transforms an array of `SportResult` objects into `DisplayableSportResult` objects.
  ///
  /// - Parameter sportResults: An array of `SportResult` objects to transform.
  /// - Returns: An array of `DisplayableSportResult` objects.
  /// - Throws: An error if the transformation fails.
  var transform: @Sendable ([SportResult]) async throws -> [DisplayableSportResult]
  
  /// Filters an array of `DisplayableSportResult` objects to only include results from the most recent day.
  ///
  /// - Parameter results: An array of `DisplayableSportResult` objects to filter.
  /// - Returns: An array of `DisplayableSportResult` objects from the most recent day.
  /// - Throws: An error if the filtering operation fails.
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
