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
    
    let firebaseRepo = FirebaseRepository()
    
    func getQuestions(set: String) {
        
        DispatchQueue.main.async {
            self.firebaseRepo.getData(ofId: "Harry Potter") { data in
                self.questionsData = data.questions
            }
           
        }


    }
    
}
