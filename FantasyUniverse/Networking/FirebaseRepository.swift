//
//  QuestionsRepository.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 10.04.2022.
//

import Foundation
import Firebase

class FirebaseRepository: QuestionsRepository {
    
    func getAllQuestions(_ completion: @escaping (_ data: [QuestionCollection]) -> Void) {
        var allCollections: [QuestionCollection] = []
        
        let group = DispatchGroup()
        
        for collection in QuestionSet.allSets {
            group.enter()
            self.getQuestionsCollection(collection) { data in
                allCollections.append(data)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(allCollections)
        }
    }
    
    func getQuestionsCollection(_ collection: QuestionSet, _ completion: @escaping (_ data: QuestionCollection) -> Void) {
        let collectionIdentifier = collection.collectionIdentifier
        let database = Firestore.firestore()
        
        database.collection(collectionIdentifier).getDocuments { (snap, err) in
            guard err == nil else {
                debugPrint(err?.localizedDescription ?? "Error while receiving data grom firebase")
                return
            }
            guard let data = snap else {
                debugPrint("No data received from firebase")
                return
            }
            
            let objects = data.documents.compactMap({ (doc) -> Question? in
                return try? doc.data(as: Question.self)
            })
            
            guard let questions = QuestionDataConverter.formatQuestions(self.randomize(objects: objects)) else {
                fatalError("There is an error converting [Questions] objects to [QuestionViewData] objects")
            }
            
            let collection = QuestionCollection(identifier: collectionIdentifier, questions: questions)
            completion(collection)
        }
    }
    
    private func randomize(objects: [Question]) -> [Question] {
        var questions: [Question] = []
        for var question in objects {
            let options = [question.optionA, question.optionB, question.optionC, question.optionD].shuffled()
            question.optionA = options[0]
            question.optionB = options[1]
            question.optionC = options[2]
            question.optionD = options[3]
            questions.append(question)
        }
        return questions.shuffled()
    }
    
}
