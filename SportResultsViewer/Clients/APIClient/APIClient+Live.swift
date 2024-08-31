import ComposableArchitecture
import Foundation

extension APIClient: DependencyKey {
  static var liveValue: APIClient {
    @Dependency(\.urlSession) var urlSession
    return Self {
      let url = URL(string: "https://restest.free.beeceptor.com/results")!
      var request = URLRequest(url: url)
      request.httpMethod = HTTPMethod.post.rawValue
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      let (data, response) = try await urlSession.data(for: request)
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        throw APIClientError.invalidResponse
      }
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      decoder.dateDecodingStrategy = .formatted(dateFormatter)
      
      
      return try decoder.decode(SportResults.self, from: data)
    }
  }
}
