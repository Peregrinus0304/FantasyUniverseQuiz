//
//  QuestionViewDataMock.swift
//  FantasyUniverseTests
//
//  Created by TarasPeregrinus on 07.06.2022.
//

import Foundation
@testable import FantasyUniverse

struct QuestionViewDataMock {
        
    static let questionOne = QuestionViewData(
        question: "question",
        answers: [
            Answer(
                answer: "optionA",
                correct: false
            ),
            Answer(
                answer: "optionB",
                correct: false
            ),
            Answer(
                answer: "optionC",
                correct: false
            ),
            Answer(
                answer: "optionD",
                correct: true)
        ]
    )
    
    static let questionTwo = QuestionViewData(
        question: "question",
        answers: [
            Answer(
                answer: "optionA",
                correct: false
            ),
            Answer(
                answer: "optionB",
                correct: false
            ),
            Answer(
                answer: "optionC",
                correct: false
            ),
            Answer(
                answer: "optionD",
                correct: true)
        ]
    )
    
    static let questionThree = QuestionViewData(
        question: "question",
        answers: [
            Answer(
                answer: "optionA",
                correct: false
            ),
            Answer(
                answer: "optionB",
                correct: false
            ),
            Answer(
                answer: "optionC",
                correct: false
            ),
            Answer(
                answer: "optionD",
                correct: true)
        ]
    )
    
}
