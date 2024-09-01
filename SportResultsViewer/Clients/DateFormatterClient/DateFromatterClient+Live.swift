import ComposableArchitecture
import Foundation

enum DateFormatterError: Error {
  case invalidDate
}

// MARK: - DateFormatterClient Live Implementation
extension DateFormatterClient: DependencyKey {
  static let liveValue = DateFormatterClient(
    string: { date in
      try Self.formatDate(date, format: "yyyy-MM-dd")
    },
    itemString: { date in
      try Self.formatDate(date, format: "d MMMM yyyy")
    }
  )
  
  private static func formatDate(_ date: Date, format: String) throws -> String {
    guard date.timeIntervalSince1970 >= -62135769600 else {
      throw DateFormatterError.invalidDate
    }
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
  }
}
