//
//  QuestionViewData.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.03.2022.
//

import Foundation

struct QuestionViewData: Identifiable {
    let id = UUID()
    let question: String
    let answers: [Answer]
    var isSubmitted = false
    var completed = false
}
