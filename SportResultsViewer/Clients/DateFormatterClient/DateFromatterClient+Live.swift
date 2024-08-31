import ComposableArchitecture
import Foundation

// Add this enum to your DateFormatterClient file if not already present
enum DateFormatterError: Error {
  case invalidDate
}

extension DateFormatterClient: DependencyKey {
  static let liveValue = DateFormatterClient(
    string: { date in
      guard date.timeIntervalSince1970 >= -62135769600 else {
        throw DateFormatterError.invalidDate
      }
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter.string(from: date)
    },
    itemString: { date in
      guard date.timeIntervalSince1970 >= -62135769600 else {
        throw DateFormatterError.invalidDate
      }
      let formatter = DateFormatter()
      formatter.dateFormat = "d MMMM yyyy"
      return formatter.string(from: date)
    }
  )
}
