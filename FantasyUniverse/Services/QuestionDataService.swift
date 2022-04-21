//
//  QuestionDataService.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.04.2022.
//

import Foundation

class QuestionDataService {
    var cachedQuestions: CachedQuestions
    let firebaseRepository: FirebaseRepository
    init() {
        self.cachedQuestions = CachedQuestions()
        self.firebaseRepository = FirebaseRepository()
    }
    
    func refreshQuestions() -> [QuestionCollection] {
        cachedQuestions.cleanCahce()
        cachedQuestions.cacheObjects(firebaseRepository.getAllQuestions())
        return cachedQuestions.getObjects()
    }
    
    func getAllQuestions() -> [QuestionCollection] {
        
        if cachedQuestions.cacheIsEmpty() {
            cachedQuestions.cacheObjects(firebaseRepository.getAllQuestions())
        }
        return cachedQuestions.getObjects()
    }
    
    func getQuestionsCollection(_ collection: QuestionSet) -> QuestionCollection {
       
        if !cachedQuestions.cacheContainObject(object: collection) {
            cachedQuestions.addToCache([firebaseRepository.getQuestionsCollection(collection)])
        }
        return cachedQuestions.getCollectionFromCache(collection)
    }

}
