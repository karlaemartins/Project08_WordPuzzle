//
//  GameViewModel.swift
//  Project08_WordPuzzle
//
//  Created by Karla E. Martins Fernandes on 20/03/26.
//

import Foundation

enum SubmitResult {
    case correct(position: Int, isLevelComplete: Bool)
    case wrong
    case alreadySolved
}

final class GameViewModel {
    
    // MARK: - State
    
    var currentAnswer: String = ""
    var solutions: [String] = []
    var score: Int = 0
    private(set) var level: Int = 1
    
    var selectedLetters: [String] = []
    var letterBits: [String] = []
    
    var clues: String = ""
    var answers: String = ""
    
    var solvedAnswers: [String] = []
    var solvedIndexes: Set<Int> = []
    
    var onUpdate: (() -> Void)?
    
    
    // MARK: - User Actions
    
    func addLetter(_ letter: String) {
        selectedLetters.append(letter)
        currentAnswer += letter
        onUpdate?()
    }

    func clearAnswer() {
        selectedLetters.removeAll()
        currentAnswer = ""
        onUpdate?()
    }
    
    func submitAnswer() -> SubmitResult {
        guard let position = solutions.firstIndex(of: currentAnswer) else {
            onUpdate?()
            return .wrong
        }
        
        if solvedIndexes.contains(position) {
            onUpdate?()
            return .alreadySolved
        }
        
        score += 1
        solvedIndexes.insert(position)
        
        selectedLetters.removeAll()
        currentAnswer = ""
        
        let isComplete = solvedIndexes.count == solutions.count
        
        onUpdate?()
        return .correct(position: position, isLevelComplete: isComplete)
    }
    
    
    // MARK: - State Updates
    
    func updateAnswer(at position: Int) {
        solvedAnswers[position] = solutions[position]
        answers = solvedAnswers.joined(separator: "\n")
        onUpdate?()
    }
    
    func goToNextLevel() {
        level += 1
        loadLevel()
    }
    
    
    // MARK: - Data Loading
    
    func loadLevel() {
        resetState()
        
        var clueString = ""
        var letterBits = [String]()
        
        guard let url = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"),
              let contents = try? String(contentsOf: url, encoding: .utf8) else {
            return
        }
        
        var lines = contents.components(separatedBy: "\n")
        lines.shuffle()
        
        for (index, line) in lines.enumerated() {
            let parts = line.components(separatedBy: ": ")
            let answer = parts[0]
            let clue = parts[1]
            
            clueString += "\(index + 1). \(clue)\n"
            
            let solutionWord = answer.replacingOccurrences(of: "|", with: "")
            solutions.append(solutionWord)
            
            solvedAnswers.append("\(solutionWord.count) letters")
            
            let bits = answer.components(separatedBy: "|")
            letterBits += bits
        }
        
        clues = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answers = solvedAnswers.joined(separator: "\n")
        
        letterBits.shuffle()
        self.letterBits = letterBits
        
        onUpdate?()
    }
    
    
    // MARK: - Helpers
    
    private func resetState() {
        solutions.removeAll()
        solvedAnswers.removeAll()
        solvedIndexes.removeAll()
        selectedLetters.removeAll()
        currentAnswer = ""
    }
}
