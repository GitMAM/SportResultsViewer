import Foundation

/// Defines the data models used in the Sports Results app.
///
/// These models represent the structure of the data received from the API and the transformed data used in the UI.

// Top-level structure
struct SportResults: Codable {
  let f1Results: [F1Result]
  let nbaResults: [NBAResult]
  let tennis: [TennisResult]
  
  enum CodingKeys: String, CodingKey {
    case f1Results
    case nbaResults
    case tennis = "Tennis"
  }
}

// F1 Result
struct F1Result: Codable {
  let publicationDate: Date
  let seconds: Double
  let tournament: String
  let winner: String
}

// NBA Result
struct NBAResult: Codable {
  let gameNumber: Int
  let loser: String
  let mvp: String
  let publicationDate: Date
  let tournament: String
  let winner: String
  
  enum CodingKeys: String, CodingKey {
    case gameNumber, mvp, publicationDate, tournament, winner
    case loser = "looser"  // Note: API uses "looser" instead of "loser"
  }
}

// Tennis Result
struct TennisResult: Codable {
  let loser: String
  let numberOfSets: Int
  let publicationDate: Date
  let tournament: String
  let winner: String
  
  enum CodingKeys: String, CodingKey {
    case numberOfSets, publicationDate, tournament, winner
    case loser = "looser"  // Note: API uses "looser" instead of "loser"
  }
}

// Extension to make all results conform to a common protocol
protocol SportResult {
  var publicationDate: Date { get }
  var tournament: String { get }
  var winner: String { get }
  var resultDescription: String { get }
}

extension F1Result: SportResult {
  var resultDescription: String {
    "\(winner) wins \(tournament) by \(String(format: "%.3f", seconds)) seconds"
  }
}

extension NBAResult: SportResult {
  var resultDescription: String {
    "\(mvp) leads \(winner) to game \(gameNumber) win in the \(tournament)"
  }
}

extension TennisResult: SportResult {
  var resultDescription: String {
    "\(tournament): \(winner) wins against \(loser) in \(numberOfSets) sets"
  }
}


struct DisplayableSportResult: Equatable, Identifiable, Comparable {
  let id = UUID()
  let publicationDate: Date
  let description: String
  var formattedPublicationDate: String?
  
  init(publicationDate: Date, description: String, formattedPublicationDate: String? = nil) {
    self.publicationDate = publicationDate
    self.description = description
    self.formattedPublicationDate = formattedPublicationDate
  }
  
  static func < (lhs: DisplayableSportResult, rhs: DisplayableSportResult) -> Bool {
    return lhs.publicationDate > rhs.publicationDate // For descending order
  }
}


/// for testing and preview
extension F1Result {
  static let mock = F1Result(
    publicationDate: Date(),
    seconds: 1.234,
    tournament: "Monaco Grand Prix",
    winner: "Lewis Hamilton"
  )
}

extension NBAResult {
  static let mock = NBAResult(
    gameNumber: 7,
    loser: "Boston Celtics",
    mvp: "LeBron James",
    publicationDate: Date(),
    tournament: "NBA Finals",
    winner: "Los Angeles Lakers"
  )
}

extension TennisResult {
  static let mock = TennisResult(
    loser: "Rafael Nadal",
    numberOfSets: 5,
    publicationDate: Date(),
    tournament: "Wimbledon",
    winner: "Novak Djokovic"
  )
}
