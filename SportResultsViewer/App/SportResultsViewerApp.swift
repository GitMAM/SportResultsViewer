
import ComposableArchitecture
import SwiftUI

@main
struct SportResultsViewerApp: App {
  var body: some Scene {
    WindowGroup {
      SportsResultsView(
        store: Store(initialState: SportsFeature.State()) {
          SportsFeature()
          // for debug uncomment this line.
          //            ._printChanges()
        }
      )
    }
  }
}
