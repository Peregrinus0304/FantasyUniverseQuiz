//
//  QuizViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.01.2022.
//

import SwiftUI
import Firebase

class QuizViewModel: ObservableObject {

//    struct QuizExecutionData {
//        var correct = 0
//        var wrong = 0
//        var answered = 0
//        var executionStatus: QuizCompletionState {
//            if 0 == 0 {
//                return .empty
//            }
//        }
//    }
    
//    enum QuizCompletionState {
//        case empty
//    }
//    @Published var completionState: QuizCompletionState = .empty

    @Published var questionsData: [QuestionViewData] = []
    @Published var correct = 0
    @Published var wrong = 0
    @Published var answered = 0
    
    init() {
        getQuestions()
    }
    
    // TODO: Check the need of clean up.
    
    func getQuestions() {
        guard let questionSetID = UserDefaults.standard.lastOpenedQuizID else {
            debugPrint("No question set ID found.")
            return
        }
        
        guard let set = QuestionSet.makeSet(from: questionSetID) else {
            debugPrint("No question set found with the selected ID.")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            QuestionDataService.shared.getQuestionsCollection(set) { data in
                self?.questionsData = data.questions
            }
        }
    }
    
}
