//
//  QuestionMock.swift
//  FantasyUniverseTests
//
//  Created by TarasPeregrinus on 12.06.2022.
//

import Foundation
@testable import FantasyUniverse

struct QuestionMock {
    
   static let completeQuestion1 = Question(
        question: "question",
        optionA: "optionA",
        optionB: "optionB",
        optionC: "optionC",
        optionD: "optionD",
        correct: "optionA",
        isSubmitted: false,
        completed: false)
    
    static let completeQuestion2 = Question(
        question: "question",
        optionA: "optionA",
        optionB: "optionB",
        optionC: "optionC",
        optionD: "optionD",
        correct: "optionA",
        isSubmitted: false,
        completed: false)
    
    static let completeQuestion3 = Question(
        question: "question",
        optionA: "optionA",
        optionB: "optionB",
        optionC: "optionC",
        optionD: "optionD",
        correct: "optionA",
        isSubmitted: false,
        completed: false)
    
    static let incompleteQuestion = Question(
        question: "question",
        optionA: "optionA",
        optionB: "optionB",
        optionC: nil,
        optionD: "optionD",
        correct: "optionA",
        isSubmitted: false,
        completed: false)
}
