import SwiftUI
import ComposableArchitecture

struct SportsResultsView: View {
  @Bindable var store: StoreOf<SportsFeature>
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
        
        VStack {
          if store.isLoading {
            ProgressView()
              .scaleEffect(1.5)
              .padding()
          } else if !store.sportResults.isEmpty {
            List {
              ForEach(store.sportResults) { result in
                EnhancedResultRowView(result: result)
              }
            }
            .listStyle(InsetGroupedListStyle())
          } else {
            emptyStateView
          }
          
          if store.shouldShowGetResultsButton {
            Button("Get Results") {
              store.send(.getResultsButtonTapped)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
            .disabled(store.isLoading)
          }
        }
      }
      .navigationTitle(store.formattedDate ?? "Sports Results")
    }
    .alert($store.scope(state: \.alert, action: \.alert))
  }
  
  private var emptyStateView: some View {
    VStack(spacing: 20) {
      Image(systemName: "sportscourt")
        .font(.system(size: 50))
        .foregroundColor(.gray)
      Text("No results yet")
        .font(.headline)
      Text("Tap the Get Results button to load sports results")
        .font(.subheadline)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
  }
}

struct EnhancedResultRowView: View {
  let result: DisplayableSportResult
  
  var body: some View {
    HStack(spacing: 12) {
      sportIcon
      VStack(alignment: .leading, spacing: 4) {
        Text(result.description)
          .font(.headline)
        if let date = result.formattedPublicationDate {
          Text("Published: \(date)")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
    }
    .padding(.vertical, 8)
  }
  
  
  // Ideally this would come from the API, something like sportsType and then we can map it
  // but unfortantely the api doesn't include that, but I thought just to leave this as a nice touch
  private var sportIcon: some View {
    Group {
      if result.description.contains("Grand Prix") {
        Image(systemName: "flag.checkered")
          .foregroundColor(.red)
      } else if result.description.contains("Roland Garros") {
        Image(systemName: "tennis.racket")
          .foregroundColor(.green)
      } else {
        Image(systemName: "basketball")
          .foregroundColor(.orange)
      }
    }
    .font(.title2)
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
