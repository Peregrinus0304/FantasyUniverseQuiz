//
//  Cache.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.04.2022.
//

import Foundation

protocol Cachable {
    associatedtype Element
    associatedtype Searched
        
    func getElements() -> [Element]
    func cacheElements(_ objects: [Element])
    func addToCache(_ objects: [Element])
    func cleanCache()
    func cacheIsEmpty() -> Bool
    func cacheContainElement(searched: Searched) -> Bool
    
}

class CachedQuestions: Cachable {

    private var cachedElements: [QuestionCollection] = []
    
    func getElements() -> [QuestionCollection] {
        return cachedElements
    }
    
    func cacheElements(_ elements: [QuestionCollection]) {
        cachedElements = elements
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
    
    func cacheContainElement(searched: QuestionSet) -> Bool {
        return cachedElements.contains { $0.identifier == searched.collectionIdentifier }
    }

    func getCollectionFromCache(_ collection: QuestionSet) -> QuestionCollection {
        let filteredCollections = cachedElements.filter { $0.identifier == collection.collectionIdentifier }
        if filteredCollections.count > 1 { debugPrint("Duplicated question collection found: \(collection)") }
        return filteredCollections[0]
    }
    
}
