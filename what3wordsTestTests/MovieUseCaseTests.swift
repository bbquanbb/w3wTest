//
//  TrendingMovieTest.swift
//  what3wordsTestTests
//
//  Created by Quan on 05/10/2023.
//

import XCTest
@testable import what3wordsTest

class MovieUseCaseImplTests: XCTestCase {
    var movieUseCase: MovieUseCase!
    
    override func setUp() {
        super.setUp()
        // Initialize the MovieUseCase with the real or mock dependencies as needed
        movieUseCase = MovieUseCaseImpl(networkService: DependencyContainer.shared.provideNetworkService(), databaseService: DependencyContainer.shared.provideDatabaseService())
    }
    
    override func tearDown() {
        movieUseCase = nil
        super.tearDown()
    }
    
    // Test the fetchTrendingMovies method
    func testFetchTrendingMovies() {
        // Set up an expectation for an async operation
        let expectation = XCTestExpectation(description: "Fetch Trending Movies")
        
        // Call the fetchTrendingMovies function
        movieUseCase.fetchTrendingMovies(page: 1) { result in
            // Handle the result and assert conditions as needed
            
            switch result {
            case .success(let trendingMovie):
                // Assert that the trendingMovie object contains the expected data
                XCTAssertNotNil(trendingMovie)
                // Add more assertions if needed
                
            case .failure(let error):
                // Handle the failure case, e.g., assert that the error is not nil
                XCTAssertNotNil(error)
                // Add more error-specific assertions if needed
            }
            
            // Fulfill the expectation to signal that the test is complete
            expectation.fulfill()
        }
        
        // Use XCTest's asynchronous method to wait for the expectation
        wait(for: [expectation], timeout: 5.0) // Adjust the timeout as needed
    }
    
    // Test the searchMovies method
    func testSearchMovies() {
        // Set up an expectation for an async operation
        let expectation = XCTestExpectation(description: "Search Movies")
        
        // Call the searchMovies function
        movieUseCase.searchMovies(query: "Action") { result in
            // Handle the result and assert conditions as needed
            
            switch result {
            case .success(let movies):
                // Assert that the movies array contains the expected data
                XCTAssertNotNil(movies)
                // Add more assertions if needed
                
            case .failure(let error):
                // Handle the failure case, e.g., assert that the error is not nil
                XCTAssertNotNil(error)
                // Add more error-specific assertions if needed
            }
            
            // Fulfill the expectation to signal that the test is complete
            expectation.fulfill()
        }
    }
    
    // Test the getMovieDetails method
    func testGetMovieDetails() {
        // Set up an expectation for an async operation
        let expectation = XCTestExpectation(description: "Get Movie Details")
        
        // Replace `yourMovieID` with a valid movie ID for testing
        let yourMovieID = 123
        
        // Call the getMovieDetails function
        movieUseCase.getMovieDetails(movieID: yourMovieID) { result in
            // Handle the result and assert conditions as needed
            
            switch result {
            case .success(let movieDetail):
                // Assert that the movieDetail object contains the expected data
                XCTAssertNotNil(movieDetail)
                // Add more assertions if needed
                
            case .failure(let error):
                // Handle the failure case, e.g., assert that the error is not nil
                XCTAssertNotNil(error)
                // Add more error-specific assertions if needed
            }
            
            // Fulfill the expectation to signal that the test is complete
            expectation.fulfill()
        }
    }
    
    // Test the loadOfflineMovies method
    func testLoadOfflineMovies() {
        // Call the loadOfflineMovies function
        let offlineMovies = movieUseCase.loadOfflineMovies()
        
        // Assert that the loaded offlineMovies array is not nil
        XCTAssertNotNil(offlineMovies)
        // Add more assertions if needed
    }
    
    func testFetchTrendingMoviesFailure() {
        // Set up an expectation for an async operation
        let expectation = XCTestExpectation(description: "Fetch Trending Movies Failure")
        
        // Inject a mock network service that always returns an error
        let mockNetworkService = MockNetworkService(result: .failure(NetworkError.noConnection))
        
        
        // Initialize the MovieUseCase with the mock network service
        let movieUseCase = MovieUseCaseImpl(networkService: mockNetworkService, databaseService: DependencyContainer.shared.provideDatabaseService())
        
        // Call the fetchTrendingMovies function
        movieUseCase.fetchTrendingMovies(page: 1) { result in
            // Handle the result and assert conditions as needed
            
            switch result {
            case .success:
                // The test should fail because we expect a failure result
                XCTFail("Expected failure, but received success")
                
            case .failure(let error):
                // Assert that the error matches the expected error type
                XCTAssertTrue(error is NetworkError)
            }
            
            // Fulfill the expectation to signal that the test is complete
            expectation.fulfill()
        }
    }
}

class MockNetworkService: NetworkService {
    typealias ResultType = Result<Data, Error>
    
    let result: ResultType
    
    init(result: ResultType) {
        self.result = result
    }
    
    func request(urlPath: String, completion: @escaping (ResultType) -> Void) {
        completion(result)
    }
}
