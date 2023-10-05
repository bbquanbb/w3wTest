# w3wTest
What3word Test

## Project Structure

The project is structured as follows:

- `w3wTest`: The main application module.
  - `Application`: Contains data-related components.
    - `Network`: Handles network requests and data retrieval.
    - `Database`: Manages local data storage.
    - `Usecases`: Implement usecases in Domain layer
  - `Domain`: Defines the core business logic and use cases.
  - `Presentation (Screens)`: Handles the UI and user interactions.
    - `ViewModels`: Contains view models that bridge the gap between the UI and domain logic.
    - `Views`: Contains the user interface components.


## Features

MovieApp provides the following features:

- Trending Movies: View a list of currently trending movies.
- Search Movies: Search for movies by title.
- Movie Details: View detailed information about a selected movie.
- Offline Support: Access previously fetched movie data when no internet connection is available.

