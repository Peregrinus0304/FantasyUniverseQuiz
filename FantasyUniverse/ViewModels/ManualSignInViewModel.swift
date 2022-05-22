//
//  ManualSighInViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.04.2022.
//

import Foundation

class ManualSignInViewModel: ObservableObject {
    
    private let validator = AuthenticationValidator()
    private let firebaseAuthService = FirebaseAuthService()
    
    func credentialsAreValid(_ credentials: ManualSignInCredentials) -> (Bool, String?) {
        let emailFieldValid = validator.isEmailValid(credentials.email)
        let passwordFieldValid = validator.isPasswordValid(credentials.password)
        var validationError: String? {
            if !passwordFieldValid && !emailFieldValid {
                return "Email and password do not fulfil requirements"
                
            } else if !passwordFieldValid {
                return "Password does not fulfil requirements"
            } else if !emailFieldValid {
                return "Email does not fulfil requirements"
            } else {
                return nil
            }
        }
        return (emailFieldValid && passwordFieldValid, validationError)
    }
    
    func signIn(with credentials: ManualSignInCredentials, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        DispatchQueue.main.async {
            self.firebaseAuthService.signIn(email: credentials.email, pass: credentials.password) { success in
                completionBlock(success)
            }
        }
    }
    
}
