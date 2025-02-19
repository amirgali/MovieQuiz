//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Amir on 13.07.2024.
//

import UIKit

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveQuestion(_ question: QuizQuestion)
}

protocol QuestionFactory {
    func requestNextQuestion()
}

final class  QuestionFactoryImpl {
    
    // MARK: - Properties
    
    private weak var delegate: QuestionFactoryDelegate?
    
    // MARK: - Init
    
    init(delegate: QuestionFactoryDelegate?) {
        self.delegate = delegate
    }
    
    // массив вопросов
    private let questions: [QuizQuestion] = [
        QuizQuestion(image: "The Godfather", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Dark Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Kill Bill", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Avengers", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Deadpool", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Green Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Old", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "The Ice Age Adventures of Buck Wild", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Tesla", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Vivarium", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false)
    ]
}

extension QuestionFactoryImpl: QuestionFactory {
    func requestNextQuestion() {
        guard let question = questions.randomElement() else {
            assertionFailure("question is empty")
            return
        }
        //        let question = questions[safe: index]
        delegate?.didReceiveQuestion(question)
    }
}

