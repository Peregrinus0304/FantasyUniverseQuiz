//
//  QuestionDataConverterTests.swift
//  FantasyUniverseTests
//
//  Created by TarasPeregrinus on 27.03.2022.
//

import XCTest
@testable import FantasyUniverse

class QuestionDataConverterTests: XCTestCase {

    var completeQuestion1: Question!
    var completeQuestion2: Question!
    var completeQuestion3: Question!
    var incompleteQuestion: Question!
    
    override func setUpWithError() throws {
        completeQuestion1 = QuestionMock.completeQuestion1
        completeQuestion2 = QuestionMock.completeQuestion2
        completeQuestion3 = QuestionMock.completeQuestion3
        incompleteQuestion = QuestionMock.incompleteQuestion
    }
    
    func test_converterReturnsNil_ifIncompleteQuestions() {
        // given
        let incompleteQuestions: [Question] = [completeQuestion1, incompleteQuestion, completeQuestion3]

        // when
        let incompleteQuestionViewData = QuestionDataConverter.formatQuestions(incompleteQuestions)

        // then
        XCTAssertNil(incompleteQuestionViewData)
    }
    
    func test_converterReturnsNotNil_ifCompleteQuestions() {
        // given
        let completeQuestions: [Question] = [completeQuestion1, completeQuestion2, completeQuestion3]

        // when
        let completeQuestionViewData = QuestionDataConverter.formatQuestions(completeQuestions)

        // then
        XCTAssertNotNil(completeQuestionViewData)
    }

}
