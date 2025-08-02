# CurrencyConvertor 💱
## What is this App All About

CurrencyConvertor is a user-friendly and efficient currency conversion app built with SwiftUI. It allows users to quickly convert amounts between a wide range of world currencies with real-time exchange rates.

-  API Used: This app uses the Open Exchange Rates API to fetch up-to-date exchange rates.

-  Real-time Conversion: Fetches the latest exchange rates from a web API to ensure accurate conversions.

-  Extensive Currency Support: The app supports a comprehensive list of global currencies, each with its corresponding country flag and name.

-  Simple Interface: A clean and intuitive design makes it easy for users to select currencies and view conversion results.

-  Currency Selection Menu: Users can easily choose their base and converted currencies from a dropdown menu that displays currency codes, flags, and names.

-  Loading Indicator: The app provides a visual loading indicator when fetching data from the API.

## What I have learned

-  Asynchronous Programming: Utilized async/await to handle network requests for fetching currency rates from an API without blocking the main thread.

-  State Management with SwiftUI: Implemented the @StateObject property wrapper to manage the app's state using a ContentViewModel class, which handles all business logic and data.

-  Data Modeling and Decoding: Created Decodable structs like Rates to parse and store JSON data from the API. The CurrencyChoice enum was used to model different currencies and their properties.

-  MVVM Design Pattern: Structured the app using the Model-View-ViewModel pattern, separating the UI (ContentView) from the data and logic (ContentViewModel).

-  User Interface with SwiftUI: Built a responsive and interactive UI using SwiftUI components like TextField, Menu, Image, Text, and ZStack.

-  Error Handling: Implemented error handling within the ContentViewModel to catch and display issues that may arise during the API call.

## Demo

![Simulator Screen Recording - iPhone 16 Pro - 2025-08-02 at 14 50 00](https://github.com/user-attachments/assets/799b4c59-c4b6-4361-9c87-da498b0ca2a4)

