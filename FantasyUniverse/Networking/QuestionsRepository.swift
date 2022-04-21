//
//  QuestionsRepository.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.04.2022.
//

import Foundation

protocol QuestionsRepository {
    func getAllQuestions() -> [QuestionCollection]
    func getQuestionsCollection(_ collection: QuestionSet) -> QuestionCollection
}
