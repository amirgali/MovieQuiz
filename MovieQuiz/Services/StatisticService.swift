//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Amir on 23.07.2024.
//

import Foundation

protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: BestGame? { get }
    
    func store(correct: Int, total: Int)
}

final class StatisticServiceImpl {
    private enum Keys: String {
        case correct, total, bestGame, gamesCount, date
    }
    
    private let userDefaults: UserDefaults = .standard
}

extension StatisticServiceImpl: StatisticService {
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    var bestGame: BestGame? {
        get {
            let correct = userDefaults.integer(forKey: Keys.correct.rawValue)
            let total = userDefaults.integer(forKey: Keys.total.rawValue)
            let date = userDefaults.object(forKey: Keys.date.rawValue) as? Date ?? Date()
            return .init(correct: correct, total: total, date: date)
        }
        set {
            guard let newValue else { return }
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
            userDefaults.set(newValue, forKey: Keys.date.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        Double(correct) / Double(total) * 100
    }
    
    func store(correct: Int, total: Int) {
        self.correct += correct
        self.total += total
        self.gamesCount += 1
        
        let currentBestGame = BestGame(correct: correct, total: total, date: Date())
        
        if currentBestGame.isBetterThan(bestGame!) {
                bestGame = currentBestGame
        }
        
//        if let previousBestGame = bestGame {
//            if currentBestGame > previousBestGame {
//                bestGame = currentBestGame
//            }
//        } else {
//            bestGame = currentBestGame
//        }
//        guard bestGame != nil else { return }
//        if currentBestGame > bestGame {
//            bestGame = currentBestGame
//        }
    }
}
