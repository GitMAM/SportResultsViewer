import ComposableArchitecture
import Foundation

/// The core feature of the Sports Results app, managing the state and business logic for fetching and displaying sports results.
///
/// This feature uses The Composable Architecture (TCA) to manage state, handle user actions, and coordinate with dependencies.

@Reducer
struct SportsFeature {
  /// Represents the current state of the Sports Results feature.
  @ObservableState
  struct State: Equatable {
    var sportResults: IdentifiedArrayOf<DisplayableSportResult> = []
    var isLoading = false
    var formattedDate: String?
    var shouldShowGetResultsButton: Bool = true
    @Presents var alert: AlertState<Action.Alert>?
  }
  
  /// Defines the actions that can occur within the Sports Results feature.
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
  
  
  /// The core logic and behavior of the Sports Results feature.
  ///
  /// This reducer handles user actions, updates state, and manages side effects like API calls.
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .getResultsButtonTapped:
        state.isLoading = true
        state.sportResults = []
        state.formattedDate = nil
        state.shouldShowGetResultsButton = false
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
          state.shouldShowGetResultsButton = state.sportResults.isEmpty
        } catch {
          state.alert = .failedFetching
          state.shouldShowGetResultsButton = true
        }
        return .none
        
      case .sportResultsResponse(.failure):
        state.isLoading = false
        state.alert = .failedFetching
        state.shouldShowGetResultsButton = true
        return .none
        
      case .alert:
        return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
}

extension AlertState where Action == SportsFeature.Action.Alert {
  static let failedFetching = Self {
    TextState("Initial Load Failed")
  } actions: {
    ButtonState(role: .cancel) {
      TextState("OK")
    }
  } message: {
    TextState("Failed to load initial list. Please try again later.")
  }
}
