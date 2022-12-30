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
    @Published var fieldsValid = false
    @Published var isAuthenticated = false
    @Published var authError: String?
    @Published var alert: AppAlert?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func validateCredentials() {
        
        let emailFieldValid = validator.isEmailValid(loginFieldValue)
        let passwordFieldValid = validator.isPasswordValid(passwordFieldValue)
        if !passwordFieldValid && !emailFieldValid {
            validationErrorMessage = ValidationResult.wrongEmailAndPassword.message
        } else if !passwordFieldValid {
            validationErrorMessage = ValidationResult.wrongPassword.message
        } else if !emailFieldValid {
            validationErrorMessage = ValidationResult.wrongEmail.message
        } else {
            validationErrorMessage = ValidationResult.none.message
            fieldsValid = true
        }
    }
    
    func signIn() {
        let credentials = ManualSignInCredentials(
            email: loginFieldValue,
            password: passwordFieldValue)
        firebaseAuthService
            .loginPublisher(with: credentials)
            .receive(on: DispatchQueue.main)
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
