//
//  TrendingMoviesViewModel.swift
//  what3wordsTest
//
//  Created by Quan on 04/10/2023.
//

import Foundation

class TrendingMovieViewModel {
    private let movieUseCase: MovieUseCase
    
    var onMoviesUpdate: (() -> Void)?
    private var movies: [Movie] = []
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var isFetchingMovies: Bool = false
    var isLoadingMore: Bool = false
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    
    func fetchTrendingMovies() {
        guard !isFetchingMovies, currentPage <= totalPages else {
            print("All pages fetched or already fetching")
            return
        }
        
        isFetchingMovies = true
        isLoadingMore = true 
        
        movieUseCase.fetchTrendingMovies(page: currentPage) { [weak self] result in
            self?.isFetchingMovies = false
            self?.isLoadingMore = false
            
            switch result {
            case .success(let trendingMovie):
                // Append the fetched movies to the existing list
                self?.movies.append(contentsOf: trendingMovie.results ?? [])
                self?.totalPages = trendingMovie.totalPages ?? 1
                
                // Update the current page
                self?.currentPage += 1
                
                self?.onMoviesUpdate?()
            case .failure(let error):
                ErrorHandler.handleError(error as! NetworkError)
                
                if let networkError = error as? NetworkError {
                    switch networkError {
                    case .noConnection:
                        self?.loadOfflineMovies()
                    default:
                        break
                    }
                    
                }
            }
        }
    }
    
    func loadOfflineMovies() {
        guard let offlineMovies = DependencyContainer.shared.provideDatabaseService().loadSavedMovies() else {
            print("No offline movies available")
            return
        }
        
        movies = offlineMovies
        onMoviesUpdate?()
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
}


