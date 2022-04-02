//
//  QuestionSets.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 08.02.2022.
//

import Foundation

enum QuestionSet {
    case test, harryPotter, lotr, starWars, stephenKing
    
    static let allSets: [QuestionSet] = [test, harryPotter, lotr, starWars, stephenKing]
    
    var collectionIdentifier: String {
        switch self {
        case .test: return "Set_1"
        case .harryPotter: return "Harry Potter"
        case .lotr: return "LOTR"
        case .starWars: return "Star Wars"
        case .stephenKing: return "Stephen King"
        }
    }
    var logoAnimationName: String {
        switch self {
        case .test: return "smile-face"
        case .harryPotter: return "harry-potter-logo"
        case .lotr: return "lotr-logo"
        case .starWars: return "star-wars-logo"
        case .stephenKing: return "stephen-king-logo"
        }
    }
}
