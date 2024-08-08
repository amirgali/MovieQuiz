//
//  MovieQuizRequestFactory.swift
//  MovieQuiz
//
//  Created by Amir on 08.08.2024.
//

import Foundation

protocol MovieQuizRequestFactory {
    func constructRequest(apiType: ApiType) -> Result<URLRequest, Error>
}

class MovieQuizRequestFactoryImpl: MovieQuizRequestFactory {
    func constructRequest(apiType: ApiType) -> Result<URLRequest, Error> {
        switch apiType {
        case .imdb:
            guard let url = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf") else {
                return .failure(NetworkError.brokenRequest)
            }
            return .success(URLRequest(url: url))
        case .kp:
            var components = URLComponents(string: "https://api.kinopoisk.dev/v1.3/movie")!
            
            components.queryItems = [
                URLQueryItem(
                    name: "selectFields",
                    value: ["name", "rating", "poster"].joined(separator: " ")
                ),
                URLQueryItem(name: "limit", value: "10"),
                URLQueryItem(name: "typeNumber", value: "1"),
                URLQueryItem(name: "top250", value: "!null")
            
            ]
            guard let url = components.url else {
                return .failure(NetworkError.brokenRequest)
            }
            var request = URLRequest(url: url)
            request.addValue("8AGCWPF-ZVQMG1D-M7MFNKE-VVYR39A", forHTTPHeaderField: "X-API-KEY")
            return .success(request)
        }
    }
}
