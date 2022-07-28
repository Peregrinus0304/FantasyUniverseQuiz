//
//  QuestionViewData.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 23.03.2022.
//

import Foundation
import FirebaseFirestoreSwift

enum QuestionDataConverter {
    
    static func formatQuestions(_ questions: [Question]) -> [QuestionViewData]? {
        var questionViewData: [QuestionViewData]?
        for question in questions {
            // swiftlint:disable line_length
            guard let questionString = question.question, let optionA = question.optionA, let optionB = question.optionB, let optionC = question.optionC, let optionD = question.optionD, let correct = question.correct
            else {
                if let missingValuesMessages = missingValuesMessages(of: question) {
                    debugPrint(missingValuesMessages)
                }
                questionViewData = nil
                break
            }
            
            let answers: [Answer] =
            [Answer(answer: optionA, correct: optionA == correct),
             Answer(answer: optionB, correct: optionB == correct),
             Answer(answer: optionC, correct: optionC == correct),
             Answer(answer: optionD, correct: optionD == correct)]
            let questionData = QuestionViewData(question: questionString, answers: answers)
            if questionViewData == nil {
                questionViewData = [QuestionViewData]()
            }
          
            questionViewData?.append(questionData)
        }
        return questionViewData
    }
    
}
