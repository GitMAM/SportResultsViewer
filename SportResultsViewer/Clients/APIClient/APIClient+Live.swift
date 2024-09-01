import ComposableArchitecture
import Foundation

extension APIClient: DependencyKey {
  static var liveValue: APIClient {
    @Dependency(\.urlSession) var urlSession
    
    return Self {
      do {
        guard let url = URL(string: "https://restest.free.beeceptor.com/results") else {
          throw APIClientError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
        
        do {
          return try decoder.decode(SportResults.self, from: data)
        } catch {
          throw APIClientError.decodingError(error)
        }
      } catch {
        throw APIClientError.networkError(error)
      }
    }
  }
}
