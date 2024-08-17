////
////  MoviesLoaderTests.swift
////  MovieQuizTests
////
////  Created by Amir on 13.08.2024.
////
//
//import XCTest
//@testable import MovieQuiz
//
//class MoviesLoaderTests: XCTestCase {
//    func testSuccessLoading() throws {
//        // Given
//        // говорим, что не хотим эмулировать ошибку
//        let stubNetworkClient = StubNetworkClient(emulateError: false)
//        let loader = MoviesLoader(networkClient: stubNetworkClient as! NetworkRouting)
//        
//        // When
//        let expectation = expectation(description: "Loading expextation")
//        
//        loader.loadMovies { result in
//            // Then
//            switch result {
//            case .success(let movies):
//                // сравниваем данные с тем, что мы предполагали
//                expectation.fulfill()
//            case .failure(_):
//                // мы не ожидаем, что пришла ошибка. Если она появится, надо будет провалить тест
//                XCTFail("Unexpected failure") // эта функция проваливает тест
//            }
//        }
//        
//        waitForExpectations(timeout: 1)
//    }
//    
//    func testFailureLoading() throws {
//        // Given
//        let stubNetworkClient = StubNetworkClient(emulateError: true) // говорим, что хотим эмулировать ошибку
//        let loader = MoviesLoader(networkClient: stubNetworkClient)
//        
//        // When
//        let expectation = expectation(description: "Loading expectation")
//        
//        loader.loadMovies { result in
//            // Then
//            switch result {
//            case .failure(let error):
//                XCTAssertNotNil(error)
//                expectation.fulfill()
//            case .success(_):
//                XCTFail("Unexpected failure")
//            }
//        }
//        
//        waitForExpectations(timeout: 1)
//    }
//}
//
