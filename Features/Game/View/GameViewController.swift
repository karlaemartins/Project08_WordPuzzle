//
//  GameViewController.swift
//  Project08_WordPuzzle
//
//  Created by Karla E. Martins Fernandes on 24/03/26.
//

import UIKit

final class GameViewController: UIViewController {
    
    private let viewModel = GameViewModel()
    private let clearButton = UIButton(type: .system)
    
    private let cluesLabel = UILabel()
    private let answersLabel = UILabel()
    private let currentAnswerLabel = UILabel()
    private let scoreLabel = UILabel()
    private var letterButtons: [UIButton] = []
    private let buttonsView = UIView()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupClearButton()
        setupConstraints()
        bindViewModel()
        viewModel.loadLevel()
    }
    
    private func setupViews() {
        setupScoreLabel()
        setupCluesLabel()
        setupAnswersLabel()
        setupCurrentAnswerLabel()
        setupLetterButtons()
    }
    
    private func setupScoreLabel() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        
        view.addSubview(scoreLabel)
    }
    
    private func setupCluesLabel() {
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.numberOfLines = 0
        
        view.addSubview(cluesLabel)
    }
    
    private func setupAnswersLabel() {
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        
        view.addSubview(answersLabel)
    }
    
    private func setupCurrentAnswerLabel() {
        currentAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        currentAnswerLabel.textAlignment = .center
        currentAnswerLabel.font = UIFont.systemFont(ofSize: 44)
        currentAnswerLabel.text = ""
        
        view.addSubview(currentAnswerLabel)
    }
    
    private func setupLetterButtons() {
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for col in 0..<5 {
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                button.setTitle("AAA", for: .normal)
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                button.frame = frame
                
                buttonsView.addSubview(button)
                letterButtons.append(button)
                
                button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
    }
    
    private func setupClearButton() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        
        view.addSubview(clearButton)
        
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),

            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -40),
            answersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -40),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswerLabel.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            currentAnswerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: currentAnswerLabel.bottomAnchor, constant: 20),
            
            clearButton.centerXAnchor.constraint(equalTo: currentAnswerLabel.centerXAnchor, constant: 100),
            clearButton.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 20),
            clearButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }

            self.cluesLabel.text = self.viewModel.clues
            self.answersLabel.text = self.viewModel.answers
            self.currentAnswerLabel.text = self.viewModel.currentAnswer
            self.scoreLabel.text = "Score: \(self.viewModel.score)"
            
            for (index, button) in self.letterButtons.enumerated() {
                if index < self.viewModel.letterBits.count {
                    button.setTitle(self.viewModel.letterBits[index], for: .normal)
                }
            }
        }
    }
    
    @objc private func letterTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        viewModel.addLetter(title)
        sender.isHidden = true
    }
    
    @objc private func clearTapped(_ sender: UIButton) {
        viewModel.clearAnswer()
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
}
