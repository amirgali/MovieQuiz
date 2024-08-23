//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Amir on 05.08.2024.
//

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<[Movie], Error>) -> Void)
}

enum ApiType {
    case imdb, kp
}

protocol MoviesQuizResponceHandler {
    func handleResponce(apiType: ApiType, data: Data) throws -> [Movie]
}

class MovieQuizResponceHandlerImpl: MoviesQuizResponceHandler {
    func handleResponce(apiType: ApiType, data: Data) throws -> [any Movie] {
        switch apiType {
        case .imdb:
            return try JSONDecoder().decode(MostPopularMovies.self, from: data).items
        case .kp:
            return try JSONDecoder().decode(KPResponce.self, from: data).docs
        }
    }
}

class MoviesLoader: MoviesLoading {
    // MARK: - NetworkClient
    private let networkClient: NetworkRouting
    private let apiType: ApiType = .imdb
    
    private lazy var requestFactory = MovieQuizRequestFactoryImpl()
    private lazy var responceHandler = MovieQuizResponceHandlerImpl()
    
    init(networkClient: NetworkRouting = NetworkClient() as! NetworkRouting) {
         self.networkClient = networkClient
     }
    
    func loadMovies(handler: @escaping (Result<[Movie], Error>) -> Void) {
        switch requestFactory.constructRequest(apiType: apiType) {
        case .success(let request):
            networkClient.fetch(request: request) { [unowned self] result in
                switch result {
                case .success(let data):
                    do {
                        let mostPopularMovies = try responceHandler.handleResponce(apiType: apiType, data: data)
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
