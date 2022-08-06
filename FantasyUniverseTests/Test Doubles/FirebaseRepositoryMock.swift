//
//  FirebaseRepositoryMock.swift
//  FantasyUniverseTests
//
//  Created by TarasPeregrinus on 05.06.2022.
//

import Foundation
@testable import FantasyUniverse

class FirebaseRepositoryMock: QuestionsRepository {
    
    let questionsMock: [QuestionViewData]
    
    init(questionsMock: [QuestionViewData]) {
        self.questionsMock = questionsMock
    }
    
    func getQuestionsCollection(_ collection: QuestionSet, _ completion: @escaping (QuestionCollection) -> Void) {
        
        let questionCollection: QuestionCollection = QuestionCollection(
                                    identifier: collection.collectionIdentifier,
                                    questions: questionsMock)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("Mock getQuestionsCollection() returned data: \(questionCollection)")

            completion(questionCollection)
        }
    }
    
    func getAllQuestions(_ completion: @escaping ([QuestionCollection]) -> Void) {
        var questionCollections: [QuestionCollection] = []
        
        QuestionSet.allSets.forEach { collection in
            let newCollection: QuestionCollection = QuestionCollection(
                                    identifier: collection.collectionIdentifier,
                                    questions: questionsMock)
            questionCollections.append(newCollection)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("Mock getAllQuestions() returned: \(questionCollections.count) elements")
            completion(questionCollections)
        }
        
    }
    
}
