//
//  DependencyManager.swift
//  what3wordsTest
//
//  Created by Quan on 03/10/2023.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    func provideMovieUseCase() -> MovieUseCase {
        return MovieUseCaseImpl(networkService: provideNetworkService(), databaseService: provideDatabaseService())
    }
    
    func provideNetworkService() -> NetworkService {
        return NetworkService()
    }
    
    func provideDatabaseService() -> DatabaseService {
        return DatabaseServiceImpl()
    }
}
