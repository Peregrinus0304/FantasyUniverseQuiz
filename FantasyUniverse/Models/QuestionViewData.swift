//
//  QuestionViewData.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.03.2022.
//

import Foundation

struct QuestionViewData: Identifiable {
    var id: String
    var question: String
    let answers: [Answer]
    let isSubmitted = false
    let completed = false
}
