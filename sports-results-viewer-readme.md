# Sports Results Viewer

## Project Structure

The Sports Results Viewer is an iOS app built using SwiftUI and the Composable Architecture (TCA). It fetches sports results from an API and displays them in a list, showing only the most recent day's results.

### Key Components:

1. **Models**: Defined in `Models.swift`, including `SportResults`, `F1Result`, `NBAResult`, and `TennisResult`.
2. **API Client**: `APIClient.swift` and `APIClient+Live.swift` handle API interactions.
3. **Date Formatter**: `DateFormatterClient.swift` and `DateFormatterClient+Live.swift` manage date formatting.
4. **Displayable Sport Result**: `DisplayableSportResultClient.swift` and `DisplayableSportResultClient+Live.swift` transform raw results into displayable format.
5. **Sports Client**: `SportsClient.swift` and `SportsClient+Live.swift` coordinate fetching and transforming sports results.
6. **Sports Feature**: `SportsFeature.swift` manages the app's state and business logic.
7. **UI**: `SportsListView.swift` contains the main view for displaying results.
8. **App Entry Point**: `SportResultsViewerApp.swift` sets up the app using TCA.

## Dependencies

1. **ComposableArchitecture (TCA)**: Used for state management, dependency injection, and testability. TCA provides a clear and scalable architecture for SwiftUI apps.

2. **SwiftUI**: Apple's declarative UI framework, chosen for its modern approach to building user interfaces and seamless integration with TCA.

3. **Foundation**: Standard library for iOS development, providing essential data types and functionalities.

4. **XCTest**: Apple's testing framework, used for unit and integration tests.

## Code Attribution

Most of the code in this project was written specifically for this take-home assignment. However, some patterns and approaches were inspired by best practices in the Swift and TCA communities:

- The use of `@DependencyClient` and the structure of the API client were inspired by TCA's official documentation and examples.
- The date formatting approach in `DateFormatterClient` was adapted from a personal project (no public link available).

## Key Areas for Review

1. **Overall Architecture**: The project uses TCA to create a clear separation of concerns and make the app easily extendable. The use of dependency injection allows for easy testing and potential future modifications.

2. **Model Transformation**: The `DisplayableSportResultClient` demonstrates how raw API data is transformed into a format suitable for display, allowing for easy addition of new sport types in the future.

3. **Error Handling and Loading States**: The app handles loading states and potential errors, providing a smooth user experience.

4. **Testing**: Comprehensive unit tests cover various scenarios, including success and failure cases for API calls and state management.

## Future Improvements

If I were to continue developing this project, I would consider the following enhancements:

1. **Caching**: Implement local caching of results to improve performance and allow offline access.
2. **Pagination**: Add support for paginated API responses to handle larger datasets efficiently.
3. **Localization**: Add support for multiple languages.
4. **Custom UI Components**: Enhance the UI with custom animations and transitions for a more polished look.
5. **Accessibility**: Improve VoiceOver support and dynamic type scaling.
6. **Widget**: Create a home screen widget to display the latest sports result.
7. **Watch App**: Develop a companion Apple Watch app for quick glances at recent results.

## Additional Notes

- The project uses Swift's latest features and follows SwiftUI best practices.
- Error messages are user-friendly while still providing enough information for debugging.
- The app's architecture allows for easy addition of new sports types without major code changes.
- Effort was made to keep the UI responsive, with loading indicators and proper error handling.

This project demonstrates a balance between clean architecture, testability, and user experience. It showcases the use of modern iOS development practices and frameworks while meeting the specific requirements of the take-home assignment.
