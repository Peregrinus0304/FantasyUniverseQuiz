//
//  AccountViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 27.07.2022.
//

import Foundation
import Combine

class AccountViewModel: ObservableObject {
    
    private let firebaseAuthService = FirebaseAuthService()
    @Published var emailFieldValue = ""
    @Published var errorMessage = ""
    @Published var isResetSuccessfull = false
    @Published var authError: String?
    @Published var alert: AppAlert?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func signOut() {
        firebaseAuthService
            .signOut()
    }
}
