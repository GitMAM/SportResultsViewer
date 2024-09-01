
import ComposableArchitecture
import SwiftUI

// I would recommend starting from the view, then the SportsFeature reducer and then drill down into the details
// of the clients when needed.

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
