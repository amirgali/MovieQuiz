//
//  NetworkRouting.swift
//  MovieQuiz
//
//  Created by Amir on 23.08.2024.
//

import Foundation

protocol NetworkRouting {
    func fetch(request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkClientInRouting {
    
}

