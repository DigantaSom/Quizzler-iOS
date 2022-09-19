//
//  ViewController.swift
//  Quizzler
//
//  Created by Diganta Som on 19/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    @IBOutlet weak var choiceThreeButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer: String = sender.currentTitle!
        let userGotItRight: Bool = quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        // wait for 0.2s then call updateUI() and then end the timer (only runs once)
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        questionLabel.text = quizBrain.getQuestionText()
        
        let answers: [String] = quizBrain.getMultipleChoices()
        choiceOneButton.setTitle(answers[0], for: .normal)
        choiceTwoButton.setTitle(answers[1], for: .normal)
        choiceThreeButton.setTitle(answers[2], for: .normal)
        
        progressBar.progress = quizBrain.getProgress()
        
        choiceOneButton.backgroundColor = UIColor.clear
        choiceTwoButton.backgroundColor = UIColor.clear
        choiceThreeButton.backgroundColor = UIColor.clear
    }
}
