//
//  Cache.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.04.2022.
//

import Foundation

protocol Cachable {
    associatedtype Object
    associatedtype Searched
        
    func getObjects() -> [Object]
    
    func cacheObjects(_ objects: [Object])
    
    func addToCache(_ objects: [Object])
    
    func cleanCahce()
    
    func cacheIsEmpty() -> Bool
    
    func cacheContainObject(object: Searched) -> Bool
    
}

class CachedQuestions: Cachable {
     
    private var cachedObjects: [QuestionCollection] = []
    
    func getObjects() -> [QuestionCollection] {
        return cachedObjects
    }
    
    func cacheObjects(_ objects: [QuestionCollection]) {
        cachedObjects = objects
    }
    
    func addToCache(_ objects: [QuestionCollection]) {
        cachedObjects += objects
    }

    func cleanCahce() {
        cachedObjects = []
    }
   
    func cacheIsEmpty() -> Bool {
        return cachedObjects.isEmpty
    }
    
    func cacheContainObject(object: QuestionSet) -> Bool {
        return cachedObjects.contains { $0.identifier == object.collectionIdentifier }
    }

    func getCollectionFromCache(_ collection: QuestionSet) -> QuestionCollection {
        let filteredCollections = cachedObjects.filter { $0.identifier == collection.collectionIdentifier }
        if filteredCollections.count > 1 { debugPrint("Duplicated question collection found: \(collection)") }
        return filteredCollections[0]
    }
    
}
