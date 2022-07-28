//
//  CachedQuestionsTests.swift
//  FantasyUniverseTests
//
//  Created by TarasPeregrinus on 22.05.2022.
//

import XCTest
@testable import FantasyUniverse

class CachedQuestionsTests: XCTestCase {
    
    var cachedQuestions: CachedQuestions!
    var firebaseRepositoryMock: FirebaseRepositoryMock!
    
    override func setUp() {
        cachedQuestions = CachedQuestions()
        firebaseRepositoryMock = FirebaseRepositoryMock(
            questionsMock: [
                TestQuestionViewData.questionOne,
                TestQuestionViewData.questionTwo,
                TestQuestionViewData.questionThree
            ]
        )
    }
    
    override func tearDownWithError() throws {
        cachedQuestions = nil
    }
    
    func testCachedQuestions_WhenCacheElements_CachedElementsShouldNotBeEmpty() {
        let expectation = XCTestExpectation(description: #function)
        
        XCTAssertTrue(cachedQuestions.cacheIsEmpty(), "The cachedQuestions should has been empty")
        
        firebaseRepositoryMock.getQuestionsCollection(.test) { questionCollection in
            self.cachedQuestions.cacheElements([questionCollection])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertFalse(self.cachedQuestions.cacheIsEmpty(), "The cachedQuestions should contain elements")
    }
    
    func testCachedQuestions_WhenCleanCache_CachedElementsShouldBeEmpty() {
        
        XCTAssertTrue(cachedQuestions.cacheIsEmpty(), "The cachedQuestions should has been empty")
        
        let someCollection = QuestionCollection(identifier: QuestionSet.test.collectionIdentifier, questions: [TestQuestionViewData.questionOne])
        
        cachedQuestions.cacheElements([someCollection])
        XCTAssertFalse(cachedQuestions.cacheIsEmpty(), "The cachedQuestions should contain elements")
        
        cachedQuestions.cleanCache()
        
        XCTAssertTrue(cachedQuestions.cacheIsEmpty(), "The cachedQuestions should not contain elements")
    }
    
    func testCachedQuestions_WhenAddToCache_CacheShouldContainElement() {
        
        XCTAssertTrue(cachedQuestions.cacheIsEmpty(), "The cachedQuestions should has been empty")
        let someSet = QuestionSet.test
        let someCollection = QuestionCollection(identifier: someSet.collectionIdentifier, questions: [TestQuestionViewData.questionOne])
        cachedQuestions.cacheElements([someCollection])
        
        XCTAssertTrue(
            cachedQuestions.cacheContainsCollectionID(searchedId: someSet.collectionIdentifier),
            "Cache does not contain element: \(someCollection)")
    }
    
    func testCachedQuestions_GetCollectionFromCache_ShouldGetElement() {
        
        XCTAssertTrue(cachedQuestions.cacheIsEmpty(), "The cachedQuestions should has been empty")
        let someSet = QuestionSet.test
        let someCollection = QuestionCollection(identifier: someSet.collectionIdentifier, questions: [TestQuestionViewData.questionOne])
        
        cachedQuestions.cacheElements([someCollection])
        XCTAssertFalse(cachedQuestions.cacheIsEmpty(), "The cachedQuestions should contain cached elements.")
        
        let cachedCollection = cachedQuestions.getCollectionFromCache(someSet)
        
        XCTAssertEqual(cachedCollection.identifier, someCollection.identifier,
                       "Cached colloction with identifier: \(cachedCollection.identifier) is not the same as: \(someCollection.identifier), that was extracted from cache")
    }
}
