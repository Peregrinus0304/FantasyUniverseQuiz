//
//  User.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 24.07.2022.
//

import Foundation
import Combine

class User: ObservableObject {
    var uid: String
    var email: String?
    var displayName: String?
    var refreshToken: String?
    
    init(uid: String, displayName: String?, email: String?, refreshToken: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.refreshToken = refreshToken
    }
    
}
