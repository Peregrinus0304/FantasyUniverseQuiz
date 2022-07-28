//
//  Cache.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.04.2022.
//

import Foundation

protocol Cachable {
    associatedtype Element
        
    func getElements() -> [Element]
    func addToCache(_ elements: [Element])
    func cleanCache()
    func cacheIsEmpty() -> Bool
}

extension Cachable {
    func cacheElements(_ elements: [Element]) {
        cleanCache()
        addToCache(elements)
    }
}

class CachedQuestions: Cachable {

    private var cachedElements: [QuestionCollection] = []
    
    func getElements() -> [QuestionCollection] {
        return cachedElements
    }
    
    func addToCache(_ elements: [QuestionCollection]) {
        cachedElements += elements
    }

    func cleanCache() {
        cachedElements = []
    }
   
    func cacheIsEmpty() -> Bool {
        return cachedElements.isEmpty
    }

    func getCollectionFromCache(_ collection: QuestionSet) -> QuestionCollection {
        let filteredCollections = cachedElements.filter { $0.identifier == collection.collectionIdentifier }
        if filteredCollections.count > 1 { debugPrint("Duplicated question collection found: \(collection)") }
        return filteredCollections[0]
    }
    
}

extension CachedQuestions {
    func cacheContainsCollectionID(searchedId: String) -> Bool {
          cachedElements.contains { $0.identifier == searchedId }
    }

}
