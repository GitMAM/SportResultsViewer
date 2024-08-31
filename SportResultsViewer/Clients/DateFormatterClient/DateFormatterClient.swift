import ComposableArchitecture
import Foundation

@DependencyClient
struct DateFormatterClient {
  var string: @Sendable (Date) throws -> String
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
