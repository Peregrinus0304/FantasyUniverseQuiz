//
//  QuestionDataService.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.04.2022.
//

import Foundation

class QuestionDataService {
    
    static let shared = QuestionDataService()
    private var cachedQuestions: CachedQuestions
    private let firebaseRepository: FirebaseRepository
    
    private init() {
        self.cachedQuestions = CachedQuestions()
        self.firebaseRepository = FirebaseRepository()
    }
    
    func refreshQuestions() {
        self.firebaseRepository.getAllQuestions { data in
            self.cachedQuestions.cacheObjects(data)
        }
    }
    
    func getAllQuestions(_ completion: @escaping (_ data: [QuestionCollection]) -> Void) {
        
        if !cachedQuestions.cacheIsEmpty() {
            completion(cachedQuestions.getObjects())
        } else {
            firebaseRepository.getAllQuestions { data in
                self.cachedQuestions.cacheObjects(data)
                completion(self.cachedQuestions.getObjects())
                
            }
            
        }
    }
    
    func getQuestionsCollection(_ collection: QuestionSet, _ completion: @escaping (_ data: QuestionCollection) -> Void) {
        if cachedQuestions.cacheContainObject(object: collection) {
            completion(cachedQuestions.getCollectionFromCache(collection))
        } else {
            firebaseRepository.getQuestionsCollection(collection) { data in
                self.cachedQuestions.addToCache([data])
                completion(self.cachedQuestions.getCollectionFromCache(collection))
            }
        }
    }
    
}
