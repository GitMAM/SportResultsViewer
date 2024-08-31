import ComposableArchitecture
import Foundation

struct SportsFeature: Reducer {
  @ObservableState
  struct State: Equatable {
    var sportResults: IdentifiedArrayOf<DisplayableSportResult> = []
    var isLoading = false
    var error: String?
    var formattedDate: String?
  }
  
  enum Action: Equatable {
    case getResultsButtonTapped
    case sportResultsResponse(TaskResult<[DisplayableSportResult]>)
  }
  
  @Dependency(\.sportsClient) var sportsClient
  @Dependency(\.date.now) var now
  @Dependency(\.dateFormatter) var dateFormatter
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .getResultsButtonTapped:
        state.isLoading = true
        state.error = nil
        state.sportResults = []
        state.formattedDate = nil
        return .run { send in
          await send(.sportResultsResponse(TaskResult { try await sportsClient.fetchSportResults() }))
        }
        
      case let .sportResultsResponse(.success(results)):
        do {
          state.isLoading = false
          state.formattedDate = "Results for \(try dateFormatter.string(results.first?.publicationDate ?? now))"
          state.sportResults = IdentifiedArrayOf(
            uniqueElements: try results.sorted().map { result in
              var formattedResult = result
              formattedResult.formattedPublicationDate = try dateFormatter.itemString(result.publicationDate)
              return formattedResult
            }
          )
        } catch let error {
          state.error = error.localizedDescription
        }
        return .none
        
      case let .sportResultsResponse(.failure(error)):
        state.isLoading = false
        state.error = error.localizedDescription
        return .none
      }
    }
  }
}
