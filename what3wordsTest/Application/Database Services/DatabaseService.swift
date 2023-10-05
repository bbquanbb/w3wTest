//
//  DatabaseService.swift
//  what3wordsTest
//
//  Created by Quan on 05/10/2023.
//

import Foundation

protocol DatabaseService {
    func saveMovies(_ movies: [Movie])
    func loadSavedMovies() -> [Movie]?
    func saveMovieDetail(_ movieDetail: MovieDetail)
    func loadMovieDetail(movieID: Int) -> MovieDetail?
}

class DatabaseServiceImpl: DatabaseService {
    private let userDefaults = UserDefaults.standard
    private let keySavedMovies = "SavedMovies"
    
    func saveMovies(_ movies: [Movie]) {
        var savedMovies = loadSavedMovies() ?? [] 
        
        for movie in movies {
            if !savedMovies.contains(where: { $0.id == movie.id }) {
                savedMovies.append(movie)
            }
        }
        
        do {
            let encodedMovies = try JSONEncoder().encode(savedMovies)
            userDefaults.set(encodedMovies, forKey: keySavedMovies)
        } catch {
            print("Error encoding movies: \(error)")
        }
    }
    
    func loadSavedMovies() -> [Movie]? {
        if let savedData = userDefaults.data(forKey: keySavedMovies) {
            do {
                let savedMovies = try JSONDecoder().decode([Movie].self, from: savedData)
                return savedMovies
            } catch {
                print("Error decoding saved movies: \(error)")
            }
        }
        return nil
    }
    
    func saveMovieDetail(_ movieDetail: MovieDetail) {
            do {
                let encodedMovieDetail = try JSONEncoder().encode(movieDetail)
                let key = "MovieDetail\(movieDetail.id!)"
                userDefaults.set(encodedMovieDetail, forKey: key)
            } catch {
                print("Error encoding movie detail: \(error)")
            }
        }
        
        func loadMovieDetail(movieID: Int) -> MovieDetail? {
            let key = "MovieDetail\(movieID)"
            if let savedData = userDefaults.data(forKey: key) {
                do {
                    // Decode the saved data using JSONDecoder
                    let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: savedData)
                    return movieDetail
                } catch {
                    print("Error decoding saved movie detail: \(error)")
                }
            }
            return nil
        }
}

