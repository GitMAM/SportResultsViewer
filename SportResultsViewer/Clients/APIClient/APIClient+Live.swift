import ComposableArchitecture
import Foundation

// MARK: - APIClient Live Implementation
extension APIClient: DependencyKey {
  static var liveValue: APIClient {
    @Dependency(\.urlSession) var urlSession
    
    return Self {
      do {
        let request = try createRequest()
        let (data, response) = try await urlSession.data(for: request)
        try validateResponse(response)
        return try decodeResponse(data)
      } catch {
        throw APIClientError.networkError(error)
      }
    }
  }
}

// MARK: - Helper Functions
private extension APIClient {
  static func createRequest() throws -> URLRequest {
    guard let url = URL(string: Constants.API.baseURL) else {
      throw APIClientError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = HTTPMethod.post.rawValue
    request.setValue(Constants.API.contentType, forHTTPHeaderField: "Content-Type")
    
    return request
  }
  
  static func validateResponse(_ response: URLResponse) throws {
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
      throw APIClientError.invalidResponse
    }
  }
  
  static func decodeResponse(_ data: Data) throws -> SportResults {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Constants.API.dateFormat
    dateFormatter.locale = Locale(identifier: Constants.API.localeIdentifier)
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    
    do {
      return try decoder.decode(SportResults.self, from: data)
    } catch {
      throw APIClientError.decodingError(error)
    }
  }
}
