//
//  GameViewModel.swift
//  Project08_WordPuzzle
//
//  Created by Karla E. Martins Fernandes on 20/03/26.
//

import Foundation

final class GameViewModel {
    
    var currentAnswer: String = ""
    var solutions: [String] = []
    var score: Int = 0
    var level: Int = 1
    var selectedLetters: [String] = []
    var clues: String = ""
    var answers: String = ""
    var letterBits: [String] = []
    
    var onUpdate: (() -> Void)?
  
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
    
    func submitAnswer() -> Int? {
        if let position = solutions.firstIndex(of: currentAnswer) {
            score += 1
            selectedLetters.removeAll()
            currentAnswer = ""
            onUpdate?()
            return position
        }
        
        return nil
        
    }
    
    func loadLevel() {
        print("loadLevel chamado")
        
        solutions.removeAll()
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let url = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            
            if let contents = try? String(contentsOf: url, encoding: .utf8) {
                
                print("arquivo carregado")
                
                var lines = contents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    
                    solutionString += "\(solutionWord.count) letters\n"
                    
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                    
                }
                
                clues = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
                answers = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

                letterBits.shuffle()
                self.letterBits = letterBits

                onUpdate?()
            }
            
        }
        
    }
}
