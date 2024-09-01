import ComposableArchitecture
import Foundation

/// A client for handling date formatting operations.
///
/// This client provides methods for converting `Date` objects to formatted strings.
@DependencyClient
struct DateFormatterClient {
  /// Converts a `Date` object to a string in the format "yyyy-MM-dd".
  ///
  /// - Parameter date: The `Date` object to format.
  /// - Returns: A formatted date string.
  /// - Throws: `DateFormatterError.invalidDate` if the date is invalid.
  var string: @Sendable (Date) throws -> String
  
  /// Converts a `Date` object to a string in the format "d MMMM yyyy".
  ///
  /// - Parameter date: The `Date` object to format.
  /// - Returns: A formatted date string.
  /// - Throws: `DateFormatterError.invalidDate` if the date is invalid.
  var itemString: @Sendable (Date) throws -> String
}

extension DependencyValues {
  var dateFormatter: DateFormatterClient {
    get { self[DateFormatterClient.self] }
    set { self[DateFormatterClient.self] = newValue }
  }
}

extension DateFormatterClient: TestDependencyKey {
  static let testValue = DateFormatterClient(
    string: { _ in "2024-08-31" },
    itemString: { _ in "31 August 2024" }
  )
}
