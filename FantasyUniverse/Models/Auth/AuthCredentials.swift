//
//  ManualSignInCredentials.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 03.05.2022.
//

import Foundation

struct ManualSignInCredentials: Codable {
    var email: String
    var password: String
}

struct SignUpCredentials: Codable {
    var email: String
    var password: String
    var firstname: String
    var lastname: String
}
