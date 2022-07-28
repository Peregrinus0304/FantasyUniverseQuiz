//
//  QuestionViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.01.2022.
//

import SwiftUI
import Firebase

class QuestionViewModel: ObservableObject {

    @Published var questionsData: [QuestionViewData] = []
    
    func getQuestions(set: QuestionSet) {
        guard set != .none else {
            debugPrint("No question set selected")
            return
        }
        
        DispatchQueue.main.async {
            QuestionDataService.shared.getQuestionsCollection(set) { data in
                self.questionsData = data.questions
            }
        }
    }
    
}
