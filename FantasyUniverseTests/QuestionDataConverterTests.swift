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
        completeQuestion1 = TestQuestion.completeQuestion1
        completeQuestion2 = TestQuestion.completeQuestion2
        completeQuestion3 = TestQuestion.completeQuestion3
        incompleteQuestion = TestQuestion.incompleteQuestion
    }
    
    func testConverter_ReturnsNil_IfIncompleteQuestions() {
        // given
        let incompleteQuestions: [Question] = [completeQuestion1, incompleteQuestion, completeQuestion3]
        
        // when
        let incompleteQuestionViewData = QuestionDataConverter.formatQuestions(incompleteQuestions)
        
        // then
        XCTAssertNil(incompleteQuestionViewData)
    }
    
    func testСonverter_ReturnsNotNil_IfCompleteQuestions() {
        // given
        let completeQuestions: [Question] = [completeQuestion1, completeQuestion2, completeQuestion3]
        
        // when
        let completeQuestionViewData = QuestionDataConverter.formatQuestions(completeQuestions)
        
        // then
        if let questionViewData = completeQuestionViewData {
            
            let questionsNotEqualMessage = "Mapped question is not equal to the original one"
            let answersNotEqualMessage = "Mapped question is not equal to the original one"
            let correctValueIsNotEqualMessage = "Mapped question`s correct value is not equal to the original question`s one"

            // check question
            XCTAssertEqual(questionViewData[0].question, completeQuestion1.question, questionsNotEqualMessage)
            XCTAssertEqual(questionViewData[1].question, completeQuestion2.question, questionsNotEqualMessage)
            XCTAssertEqual(questionViewData[2].question, completeQuestion3.question, questionsNotEqualMessage)
            
            // check answers
            let firstQuestionDataAnswers = questionViewData[0].answers.map { $0.answer }
            let firstQuestionAnswers = [completeQuestion1.optionA,
                                        completeQuestion1.optionB,
                                        completeQuestion1.optionC,
                                        completeQuestion1.optionD]
            
            XCTAssertEqual(firstQuestionDataAnswers, firstQuestionAnswers, answersNotEqualMessage)
            
            let secondQuestionDataAnswers = questionViewData[1].answers.map { $0.answer }
            let secondQuestionAnswers = [completeQuestion2.optionA,
                                         completeQuestion2.optionB,
                                         completeQuestion2.optionC,
                                         completeQuestion2.optionD]
            
            XCTAssertEqual(secondQuestionDataAnswers, secondQuestionAnswers, answersNotEqualMessage)
            
            let thirdQuestionDataAnswers = questionViewData[2].answers.map { $0.answer }
            let thirdQuestionAnswers = [completeQuestion3.optionA,
                                        completeQuestion3.optionB,
                                        completeQuestion3.optionC,
                                        completeQuestion3.optionD]
            
            XCTAssertEqual(thirdQuestionDataAnswers, thirdQuestionAnswers, answersNotEqualMessage)
            
            // check correct answer
            let firstAnswerCorrectQuestion = questionViewData[0].answers.filter { $0.correct }.map { $0.answer }[0]
            let secondAnswerCorrectQuestion = questionViewData[1].answers.filter { $0.correct }.map { $0.answer }[0]
            let thirdAnswerCorrectQuestion = questionViewData[2].answers.filter { $0.correct }.map { $0.answer }[0]
            
            XCTAssertEqual(firstAnswerCorrectQuestion, completeQuestion1.correct, correctValueIsNotEqualMessage)
            XCTAssertEqual(secondAnswerCorrectQuestion, completeQuestion2.correct, correctValueIsNotEqualMessage)
            XCTAssertEqual(thirdAnswerCorrectQuestion, completeQuestion3.correct, correctValueIsNotEqualMessage)
            
        } else {
            XCTFail("There is nil, instead of the mapped questions collection.")
        }
    }
}
