//
//  SignUpViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 14.05.2022.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    private let validator = AuthenticationValidator()
    
    func credentialsAreValid(_ credentials: ManualSignInCredentials) -> Bool {
        return validator.isEmailValid(credentials.email) && validator.isPasswordValid(credentials.password)
    }
    
}

