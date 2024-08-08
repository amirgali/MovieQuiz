//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Amir on 05.08.2024.
//

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<[MostPopularMovies], Error>) -> Void)
}

enum ApiType {
    case imdb, kp
}

class MoviesLoader: MoviesLoading {
    // MARK: - NetworkClient
    private let networkClient = NetworkClient()
    private let apiType: ApiType = .imdb
    
    private lazy var requestFactory = MovieQuizRequestFactoryImpl()
    
    
    func loadMovies(handler: @escaping (Result<[MostPopularMovies], Error>) -> Void) {
        switch requestFactory.constructRequest(apiType: apiType) {
        case .success(let request):
            networkClient.fetch(request: request) { result in
                switch result {
                case .success(let data):
                    do {
                        let mostPopularMovies = try JSONDecoder().decode([MostPopularMovies].self, from: data)
                        handler(.success(mostPopularMovies))
                    } catch {
                        handler(.failure(error))
                    }
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        case .failure(let error):
            handler(.failure(error))
            
        }
    }
    
}
