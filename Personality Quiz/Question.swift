//
//  Question.swift
//  Personality Quiz
//
//  Created by Zane Jones on 2/14/23.
//

import Foundation
import UIKit
struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, range
}

struct Answer {
    var text: String
    var type: BreadType
}

enum BreadType: String {
    case white = "White Bread", wheat = "Wheat Bread", sourdough = "Sourdough Bread", rye = "Rye Bread"
    
    var definition: String {
        switch self {
        case .white:
            return "Everyone likes you, but everyone knows you're not the healthiest."
        case .wheat:
            return "You ruin the childhoods of many you health nut"
        case .sourdough:
            return "You're a step above the rest...and you make great soup"
        case .rye:
            return "You are a great person in VERY particular situations"
        }
    }
    var picture: UIImage {
        switch self {
        case . white:
            return UIImage(named: "whiteBread")!
        case .wheat:
            return UIImage(named: "wheatBread")!
        case .sourdough:
            return UIImage(named: "sourdoughBread")!
        case .rye:
            return UIImage(named: "ryeBread")!
        }
    }
}
