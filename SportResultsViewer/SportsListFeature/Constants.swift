import SwiftUI

enum Constants {
  enum UI {
    static let backgroundColor = Color.gray.opacity(0.1)
    static let progressViewScale: CGFloat = 1.5
    static let cornerRadius: CGFloat = 10
    static let defaultPadding: CGFloat = 16
    static let iconSize: CGFloat = 50
    static let rowSpacing: CGFloat = 12
    static let rowVerticalPadding: CGFloat = 8
  }
  
  enum Text {
    static let navigationTitle = "Sports Results"
    static let getResultsButton = "Get Results"
    static let emptyStateTitle = "No results yet"
    static let emptyStateDescription = "Tap the Get Results button to load sports results"
    static let publishedPrefix = "Published: "
  }
  
  enum Images {
    static let emptyState = "sportscourt"
    static let f1 = "flag.checkered"
    static let tennis = "tennis.racket"
    static let basketball = "basketball"
  }
  
  enum Colors {
    static let f1 = Color.red
    static let tennis = Color.green
    static let basketball = Color.orange
  }
  
  enum SportKeywords {
    static let f1 = "Grand Prix"
    static let tennis = "Roland Garros"
  }
  
  enum API {
    static let baseURL = "https://restest.free.beeceptor.com/results"
    static let contentType = "application/json"
    static let dateFormat = "MMM d, yyyy h:mm:ss a"
    static let localeIdentifier = "en_US_POSIX"
  }
}
