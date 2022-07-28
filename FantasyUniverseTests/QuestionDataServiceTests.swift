//
//  QuestionDataServiceTests.swift
//  FantasyUniverseTests
//
//  Created by TarasPeregrinus on 27.03.2022.
//

import XCTest
@testable import FantasyUniverse

class QuestionDataServiceTests: XCTestCase {
    // swiftlint:disable line_length
    let completeQuestion1 = Question(question: "question", optionA: "optionA", optionB: "optionB", optionC: "optionC", optionD: "optionD", correct: "optionA", isSubmitted: false, completed: false)
    let completeQuestion2 = Question(question: "question", optionA: "optionA", optionB: "optionB", optionC: "optionC", optionD: "optionD", correct: "optionA", isSubmitted: false, completed: false)
    let completeQuestion3 = Question(question: "question", optionA: "optionA", optionB: "optionB", optionC: "optionC", optionD: "optionD", correct: "optionA", isSubmitted: false, completed: false)
    let incompleteQuestion = Question(question: "question", optionA: "optionA", optionB: "optionB", optionC: nil, optionD: "optionD", correct: "optionA", isSubmitted: false, completed: false)
    
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testQuestionToQuestionViewDataConverting() throws {
      
        // given
        let completeQuestions = [completeQuestion1, completeQuestion2, completeQuestion3]
        let incompleteQuestions = [completeQuestion1, incompleteQuestion, completeQuestion3]

        // when
        let completeQuestionViewData = QuestionDataService.formatQuestions(completeQuestions)
        let incompleteQuestionViewData = QuestionDataService.formatQuestions(incompleteQuestions)

        // then
        XCTAssertNil(incompleteQuestionViewData)
        XCTAssertNotNil(completeQuestionViewData)
    }

}
