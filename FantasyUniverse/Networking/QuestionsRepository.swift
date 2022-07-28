//
//  QuestionsRepository.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.04.2022.
//

import Foundation

protocol QuestionsRepository {
    func getAllQuestions(_ completion: @escaping (_ data: [QuestionCollection]) -> Void)
    func getQuestionsCollection(_ collection: QuestionSet, _ completion: @escaping (_ data: QuestionCollection) -> Void)
}
