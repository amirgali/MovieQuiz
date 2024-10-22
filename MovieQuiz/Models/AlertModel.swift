//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Amir on 24.07.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let buttonAction: () -> Void
}
