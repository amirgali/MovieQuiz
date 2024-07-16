//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Amir on 15.07.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
