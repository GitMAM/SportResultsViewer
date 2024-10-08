# Sports Results Viewer

https://github.com/user-attachments/assets/4863ac7c-0129-4d31-a79a-1c45656f3c62

Hey there! Welcome to my Sports Results Viewer project. I had fun working on this, and I hope you like looking through it as much as I enjoyed building it.

## Project Structure

Here's how I've organized the project:

```
SportResultsViewer
├── SportResultsViewer
│   ├── App
│   │   └── SportResultsViewerApp.swift
│   ├── Models
│   ├── Clients
│   │   ├── APIClient
│   │   │   ├── APIClient.swift
│   │   │   ├── APIClient+Live.swift
│   │   │   └── APIClientError.swift
│   │   ├── SportsClient
│   │   │   ├── SportsClient.swift
│   │   │   └── SportsClient+Live.swift
│   │   ├── DateFormatterClient
│   │   │   ├── DateFormatterClient.swift
│   │   │   └── DateFromatterClient+Live.swift
│   │   └── DisplayableSportResultClient
│   │       ├── DisplayableSportResultClient.swift
│   │       └── DisplayableSportResultClient+Live.swift
│   ├── SportsListFeature
│   │   ├── SportsFeature.swift
│   │   └── SportsListView.swift
│   └── Assets
└── SportResultsViewerTests
```

## How I've Set It Up

I've broken the app down into these main parts:

1. **App**: `SportResultsViewerApp.swift` is the entry point, kicking everything off.
2. **Models**: All the data structures live here. You'll find stuff like `SportResults`, `F1Result`, `NBAResult`, and `TennisResult`.
3. **Clients**: This is where all the behind-the-scenes magic happens:
   - `APIClient`: Handles talking to the API.
   - `SportsClient`: Brings it all together, fetching and transforming the results.
   - `DateFormatterClient`: Deals with making dates look pretty.
   - `DisplayableSportResultClient`: Turns the raw API data into something we can actually show on screen.
4. **SportsListFeature**: This is where the main action is:
   - `SportsFeature.swift`: Manages the app's state and logic.
   - `SportsListView.swift`: Where the UI magic happens.
5. **Assets**: For any images or resources the app needs.
6. **Tests**: In `SportResultsViewerTests`, making sure everything works as it should.

## What I'm Using

1. [**ComposableArchitecture (TCA)**](https://github.com/pointfreeco/swift-composable-architecture): The Composable Architecture (TCA, for short) is a library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind. It can be used in SwiftUI, UIKit, and more, and on any Apple platform (iOS, macOS, visionOS, tvOS, and watchOS).
Note, all the packages that are installed are part of the architecture package. 
2. **SwiftUI**: Apple's cool new UI framework. It plays really nice with TCA and made building the interface a breeze.

## Where'd The Code Come From?

Most of this I wrote from scratch for this project. It's based on my experince working on apps using TCA.

## Other

1. **The Architecture**: I really tried to make everything clean and extendable using TCA. It should be pretty easy to add new features down the line.

2. **How the data is handled**: seprate client for data transformation `DisplayableSportResultClient`. 

3. **Tests**: I made sure to add test coverage to the main logic of the app.

## What I'd Do Next

If I had more time, here's what I'd love to add:

1. **Caching**: So you can check results even without internet.
2. **Pagination**: Not sure if the API supports that.
3. **Localization**: 
5. **Accessibility**: Making sure everyone can use the app easily.

## Extras

- I tried to use the latest Swift features where it made sense.
- The error messages should be helpful for users but also give enough info for debugging.
- Adding new types of sports should be pretty straightforward with how I've set things up.

Thanks for checking out my project! I had a great time working on it and I'm excited to hear what you think. If you have any questions or want me to explain anything, just let me know!
