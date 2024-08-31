import ComposableArchitecture
import SwiftUI

struct SportsResultsView: View {
  @Bindable private var store: StoreOf<SportsFeature>
  
  init(store: StoreOf<SportsFeature>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: 0) {
      headerView
      
      if store.isLoading {
        loadingView
      } else if !store.sportResults.isEmpty {
        resultsView
      } else {
        initialView
      }
    }
    .background(Color.secondary)
    .edgesIgnoringSafeArea(.top)
  }
  
  private var headerView: some View {
    VStack(spacing: 4) {
      Text("Sports Results")
        .font(.system(size: 34, weight: .bold))
        .foregroundColor(.white)
      
      if let formattedDate = store.formattedDate {
        Text(formattedDate)
          .font(.system(size: 17))
          .foregroundColor(.white.opacity(0.8))
      }
    }
    .padding(.top, 44)
    .padding(.bottom, 16)
    .frame(maxWidth: .infinity)
    .background(Color.black.opacity(0.2))
  }
  
  private var loadingView: some View {
    ProgressView()
      .scaleEffect(2)
      .progressViewStyle(CircularProgressViewStyle(tint: .white))
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  private var resultsView: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(store.sportResults) { result in
          ResultCardView(result: result)
        }
      }
      .padding(.horizontal)
      .padding(.top, 16)
    }
    .background(Color.clear)
  }
  
  private var initialView: some View {
    VStack {
      Button("Get Results") {
        store.send(.getResultsButtonTapped)
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .foregroundColor(.blue)
      .cornerRadius(10)
      .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct ResultCardView: View {
  let result: DisplayableSportResult
  @State private var isExpanded = true
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text(result.description)
          .font(.headline)
          .foregroundColor(.black)
        
        Spacer()
        
        Image(systemName: "chevron.up")
          .foregroundColor(.blue)
          .rotationEffect(.degrees(isExpanded ? 180 : 0))
      }
      .contentShape(Rectangle())
      .onTapGesture {
        withAnimation {
          isExpanded.toggle()
        }
      }
      
      if isExpanded, let formattedDate = result.formattedPublicationDate {
        Text("Publication Date: \(formattedDate)")
          .font(.subheadline)
          .foregroundColor(.gray)
      }
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
  }
}
