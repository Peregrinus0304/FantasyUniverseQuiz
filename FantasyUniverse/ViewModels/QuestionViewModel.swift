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
    
    func getQuestions(set: String) {
        
        let database = Firestore.firestore()
        database.collection(set).getDocuments { (snap, err) in
            guard err == nil else {
                debugPrint(err?.localizedDescription ?? "Error while receiving data grom firebase")
                return
            }
            guard let data = snap else {
                debugPrint("No data received from firebase")
                return
            }
            
            DispatchQueue.main.async { 
                
                let objects = data.documents.compactMap({ (doc) -> Question? in
                    return try? doc.data(as: Question.self)
                })
                   
                if let questioins = QuestionDataService.formatQuestions(self.randomize(objects: objects)) {
                    self.questionsData = questioins
                } else {
                    fatalError("There is an error converting [Questions] objects to [QuestionViewData] objects")
                }
                
            }
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
