import SwiftUI
import ComposableArchitecture

/// The main view for displaying sports results.
///
/// This view uses SwiftUI and integrates with The Composable Architecture to display and manage sports results.
struct SportsResultsView: View {
  @Bindable var store: StoreOf<SportsFeature>
  
  var body: some View {
    NavigationView {
      ZStack {
        Constants.UI.backgroundColor.edgesIgnoringSafeArea(.all)
        
        VStack {
          if store.isLoading {
            ProgressView()
              .scaleEffect(Constants.UI.progressViewScale)
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
            Button(Constants.Text.getResultsButton) {
              store.send(.getResultsButtonTapped)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(Constants.UI.cornerRadius)
            .padding()
            .disabled(store.isLoading)
          }
        }
      }
      .navigationTitle(store.formattedDate ?? Constants.Text.navigationTitle)
    }
    .alert($store.scope(state: \.alert, action: \.alert))
  }
  
  private var emptyStateView: some View {
    VStack(spacing: Constants.UI.defaultPadding) {
      Image(systemName: Constants.Images.emptyState)
        .font(.system(size: Constants.UI.iconSize))
        .foregroundColor(.gray)
      Text(Constants.Text.emptyStateTitle)
        .font(.headline)
      Text(Constants.Text.emptyStateDescription)
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
    HStack(spacing: Constants.UI.rowSpacing) {
      sportIcon
      VStack(alignment: .leading, spacing: 4) {
        Text(result.description)
          .font(.headline)
        if let date = result.formattedPublicationDate {
          Text("\(Constants.Text.publishedPrefix)\(date)")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
    }
    .padding(.vertical, Constants.UI.rowVerticalPadding)
  }
  
  private var sportIcon: some View {
    Group {
      if result.description.contains(Constants.SportKeywords.f1) {
        Image(systemName: Constants.Images.f1)
          .foregroundColor(Constants.Colors.f1)
      } else if result.description.contains(Constants.SportKeywords.tennis) {
        Image(systemName: Constants.Images.tennis)
          .foregroundColor(Constants.Colors.tennis)
      } else {
        Image(systemName: Constants.Images.basketball)
          .foregroundColor(Constants.Colors.basketball)
      }
    }
    .font(.title2)
  }
}
