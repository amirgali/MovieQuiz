//
//  KPResponce.swift
//  MovieQuiz
//
//  Created by Amir on 08.08.2024.
//

import Foundation

// MARK: - Welcome
struct KPResponce: Codable {
    let docs: [KPMovie]
}

// MARK: - Doc
struct KPMovie: Codable {
    let title: String
    let poster: Poster
    let kpRating: Rating
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case poster = "poster"
        case kpRating = "rating"
    }
}

extension KPMovie: Movie {
    var rating: String {
        "\(kpRating.kp)"
    }
    
    var imageURL: URL {
        URL(string: poster.previewURL)!
    }
    
    var resizedImageURL: URL {
        URL(string: poster.previewURL)!
    }
}

// MARK: - Poster
struct Poster: Codable {
    let url, previewURL: String

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL = "previewUrl"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let kp: Double
}
