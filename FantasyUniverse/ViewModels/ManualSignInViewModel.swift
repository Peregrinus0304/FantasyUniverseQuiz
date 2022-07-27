//
//  ManualSighInViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.04.2022.
//

import Foundation
import Combine

class ManualSignInViewModel: ObservableObject {
    
    private let validator = AuthenticationValidator()
    private let firebaseAuthService = FirebaseAuthService()
    @Published var loginFieldValue = ""
    @Published var passwordFieldValue = ""
    @Published var validationErrorMessage = ""
    @Published var isAuthenticated = false
    @Published var authError: String?
    @Published var alert: AppAlert?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func validateCredentials() -> (areValid: Bool, erorrMassage: String?) {
        let emailFieldValid = validator.isEmailValid(loginFieldValue)
        let passwordFieldValid = validator.isPasswordValid(passwordFieldValue)
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
    
    func signIn() {
        let credentials = ManualSignInCredentials(
            email: loginFieldValue,
            password: passwordFieldValue)
        firebaseAuthService
            .loginPublisher(with: credentials)
            .sink { res in
                switch res {
                case .failure(let err):
                    self.alert = .authError(message: err.localizedDescription)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.isAuthenticated = true
            }
            .store(in: &subscriptions)
    }
}
