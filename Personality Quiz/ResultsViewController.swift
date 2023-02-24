//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Zane Jones on 2/10/23.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var breadImage: UIImageView!
    @IBOutlet var breadLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    var responses: [Answer]

    init? (responses: [Answer], coder: NSCoder) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateResults()
        navigationItem.hidesBackButton = true
        }
    
     func calculateResults() {
         let frequencyOfAnswers = responses.reduce(into: [:]) {
             (counts, answer) in counts[answer.type, default: 0] += 1
         }
         let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 >
             $1.1 }.first!.key
         breadLabel.text = mostCommonAnswer.rawValue
         breadImage.image = mostCommonAnswer.picture
         definitionLabel.text = mostCommonAnswer.definition
     }
    }
    

