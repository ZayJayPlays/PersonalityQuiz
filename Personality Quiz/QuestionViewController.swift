//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Zane Jones on 2/10/23.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabel1: UILabel!
    @IBOutlet var multipleLabel2: UILabel!
    @IBOutlet var multipleLabel3: UILabel!
    @IBOutlet var multipleLabel4: UILabel!
    @IBOutlet var multipleSwitch1: UISwitch!
    @IBOutlet var multipleSwitch2: UISwitch!
    @IBOutlet var multipleSwitch3: UISwitch!
    @IBOutlet var multipleSwitch4: UISwitch!
    
    @IBOutlet var rangeStackView: UIStackView!
    @IBOutlet var rangeLabel1: UILabel!
    @IBOutlet var rangeLabel2: UILabel!
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var progressBar: UIProgressView!
    
    var questionIndex = 0
    var questions: [Question] = [
        Question(text: "Which type of sandwhich is best", type: .single, answers: [
            Answer(text: "PB & J", type: .white),
            Answer(text: "Cubano", type: .wheat),
            Answer(text: "Rueben", type: .rye),
            Answer(text: "Pizza", type: .sourdough)
        ]
                ),
        Question(text: "Which of these states have you visited", type: .multiple, answers: [
            Answer(text: "New York", type: .white),
            Answer(text: "Kansas", type: .wheat),
            Answer(text: "North Dakota", type: .rye),
            Answer(text: "California", type: .sourdough)
        ]
                ),
        Question(text: "Do you like health?", type: .range, answers: [
            Answer(text: "Not at all", type: .white),
            Answer(text: "A decent amount", type: .sourdough),
            Answer(text: "Of course", type: .rye),
            Answer(text: "GIMME THAT KALE", type: .wheat)
        ]
                )
    ]
    
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let currentProgress = Float(questionIndex) / Float(questions.count)
        progressBar.progress = currentProgress
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = questions[questionIndex].text
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
            break
        case .multiple:
            updateMultipleStack(using: currentAnswers)
            break
        case .range:
            updateRangeStack(using: currentAnswers)
            break
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleLabel1.text = answers[0].text
        multipleLabel2.text = answers[1].text
        multipleLabel3.text = answers[2].text
        multipleLabel4.text = answers[3].text
    }
    
    func updateRangeStack(using answers: [Answer]) {
        rangeStackView.isHidden = false
        rangeLabel1.text = answers.first?.text
        rangeLabel2.text = answers.last?.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        }
        else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
}
        nextQuestion()
    }
    
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        if multipleSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multipleSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multipleSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multipleSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangeButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    @IBSegueAction func resultsSegue(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(responses: answersChosen, coder: coder)
    }
    
    
}
