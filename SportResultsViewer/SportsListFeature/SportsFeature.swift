import ComposableArchitecture
import Foundation

@Reducer
struct SportsFeature {
  @ObservableState
  struct State: Equatable {
    var sportResults: IdentifiedArrayOf<DisplayableSportResult> = []
    var isLoading = false
    var formattedDate: String?
    @Presents var alert: AlertState<Action.Alert>?
  }
  
  enum Action: Equatable {
    case getResultsButtonTapped
    case sportResultsResponse(TaskResult<[DisplayableSportResult]>)
    case alert(PresentationAction<Alert>)
    
    enum Alert: Equatable {
      case error(String)
    }
  }
  
  @Dependency(\.sportsClient) var sportsClient
  @Dependency(\.date.now) var now
  @Dependency(\.dateFormatter) var dateFormatter
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .getResultsButtonTapped:
        state.isLoading = true
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
        } catch {
          state.alert = .failedFetching
        }
        return .none
        
      case .sportResultsResponse:
        state.isLoading = false
        state.alert = .failedFetching
        return .none
        
      case .alert:
        return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
}
