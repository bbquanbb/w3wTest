//
//  SearchMovieViewModel.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import Foundation
import Combine

class SearchMovieViewModel {
    private let movieUseCase: MovieUseCase
    private var cancellables: Set<AnyCancellable> = []
    private let searchTextSubject = PassthroughSubject<String, Never>()
    
    private var searchResults: [Movie] = []
    var onMoviesUpdate: (() -> Void)?
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
        
        searchTextSubject
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] searchText in
                self?.searchMovies(with: searchText)
            })
            .store(in: &cancellables)
    }
    
    func searchTextDidChange(_ searchText: String) {
        searchTextSubject.send(searchText)
    }
    
    private func searchMovies(with searchText: String) {
        movieUseCase.searchMovies(query: searchText) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.searchResults = movies
                self?.onMoviesUpdate?()
            case .failure(let error):
                ErrorHandler.handleError(error as! NetworkError)
            }
        }
    }
    
    func movie(at index: Int) -> Movie {
        return searchResults[index]
    }
    
    func numberOfMovies() -> Int {
        return searchResults.count
    }
}

