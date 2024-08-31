# Sports Results Viewer

Hey there! Welcome to my Sports Results Viewer project. I had a blast working on this, and I hope you enjoy looking through it as much as I enjoyed building it.

## What's This All About?

This is an iOS app I built using SwiftUI and The Composable Architecture (TCA). It grabs sports results from an API and shows them in a neat list, focusing on the most recent day's results.

## How I've Set It Up

I've broken the app down into these main parts:

1. **Models**: All the data structures live in `Models.swift`. You'll find stuff like `SportResults`, `F1Result`, `NBAResult`, and `TennisResult` in there.
2. **API Stuff**: `APIClient.swift` and `APIClient+Live.swift` handle talking to the API.
3. **Date Wrangling**: `DateFormatterClient.swift` and its live counterpart deal with making dates look pretty.
4. **Result Transformation**: `DisplayableSportResultClient.swift` turns the raw API data into something we can actually show on screen.
5. **Sports Client**: `SportsClient.swift` brings it all together, fetching and transforming the results.
6. **The Brains**: `SportsFeature.swift` manages the app's state and logic.
7. **The Face**: `SportsListView.swift` is where the UI magic happens.
8. **The Kickoff**: `SportResultsViewerApp.swift` gets everything up and running.

## What I'm Using

1. **ComposableArchitecture (TCA)**: I chose this for managing state and dependencies. It's really helped keep things organized and testable.

2. **SwiftUI**: Apple's cool new UI framework. It plays really nice with TCA and made building the interface a breeze.

3. **Foundation**: Can't build an iOS app without it!

4. **XCTest**: For making sure everything works as it should.

## Where'd The Code Come From?

Most of this I wrote from scratch for this project. But I'll be honest, I did take some inspiration:

- The way I set up the API client borrows a bit from TCA's docs and examples.
- The date formatting stuff? I adapted that from a personal project I worked on a while back.

## What I'm Most Proud Of

1. **The Architecture**: I really tried to make everything clean and extendable using TCA. It should be pretty easy to add new features down the line.

2. **How I Handle the Data**: Check out `DisplayableSportResultClient`. I think it does a neat job of turning the API data into something usable, and it should make adding new sports types a breeze.

3. **Error Handling**: I put some effort into making sure the app doesn't just crash when something goes wrong.

4. **Tests**: I wrote a bunch of tests to cover different scenarios. Always good to make sure things are working!

## What I'd Do Next

If I had more time, here's what I'd love to add:

1. **Caching**: So you can check results even without internet.
2. **Pagination**: For when there are tons of results.
3. **Multiple Languages**: Because sports are global!
4. **Fancy UI**: Some cool animations would be nice.
5. **Accessibility**: Making sure everyone can use the app easily.
6. **Widget**: A home screen widget could be pretty cool.
7. **Apple Watch App**: For quick glances at the latest scores.

## Extra Bits

- I tried to use the latest Swift features where it made sense.
- The error messages should be helpful for users but also give enough info for debugging.
- Adding new types of sports should be pretty straightforward with how I've set things up.
- I focused on making the UI responsive, so users aren't left hanging.

Thanks for checking out my project! I had a great time working on it and I'm excited to hear what you think. If you have any questions or want me to explain anything, just let me know!
