//
//  AppState.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 24.07.2022.
//

import Combine
import Firebase
import SwiftUI

// TODO: Will work on it
// swiftlint:disable:previous todo
class AppState: ObservableObject {
    @ObservedObject var authService: FirebaseAuthService
    @Published var user: User?
    init() {
       authService = FirebaseAuthService()
       user = authService.currentUser
    }

    func userLoggedIn() -> Bool {
        return authService.currentUser != nil
    }
}
