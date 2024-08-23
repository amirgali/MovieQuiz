//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Amir on 05.08.2024.
//

import Foundation


/// Отвечает за загрузку данных по URL
struct NetworkClient {
    
    private enum NetworkError: Error {
        case codeError, brokenRequest
    }
    
    func fetch(request: URLRequest, handler: @escaping (Result<Data, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверяем, пришла ли ошибка
            if let error = error {
                handler(.failure(error))
                return
            }
            
            // Проверяем, что нам пришёл успешный код ответа
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            
            // Возвращаем данные
            guard let data = data else { return handler(.failure(data as! Error))}
            handler(.success(data))
        }
        
        task.resume()
    }
}

extension Data {
    func printPrettyJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        }
    }
}
