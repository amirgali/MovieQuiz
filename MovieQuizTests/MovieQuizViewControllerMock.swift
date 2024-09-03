//
//  MovieQuizViewControllerMock.swift
//  MovieQuizTests
//
//  Created by Amir on 01.09.2024.
//

import XCTest
import Foundation

@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func showResults() {
        
    }
    
    func resetBorderAndButtons() {
        
    }
    
    func show(quiz step: QuizStepViewModel) {
        
    }

    func highlightImageBorder(isCorrectAnswer: Bool) {
        
    }

    func showLoadingIndicator() {
        
    }

    func hideLoadingIndicator() {
        
    }

    func showNetworkError(message: String) {
        
    }

}

final class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.text, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
