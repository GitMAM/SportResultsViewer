import Foundation

// MARK: - APIClientError Error Handling
/// Enum representing errors that can occur in the APIClient
enum APIClientError: Error, LocalizedError, Equatable {
  case invalidURL
  case invalidResponse
  case networkError(Error)
  case decodingError(Error)
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "The URL is invalid."
    case .networkError(let error):
      return "Network error occurred: \(error.localizedDescription)"
    case .decodingError(let error):
      return "Failed to decode response: \(error.localizedDescription)"
    case .invalidResponse:
      return "Invalid response"
    }
  }
  
  static func == (lhs: APIClientError, rhs: APIClientError) -> Bool {
    lhs.errorDescription == rhs.errorDescription
  }
}
