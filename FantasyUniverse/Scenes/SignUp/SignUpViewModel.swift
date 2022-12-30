//
//  SignUpViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 14.05.2022.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    private let validator = AuthenticationValidator()
    private let firebaseAuthService = FirebaseAuthService()
    @Published var emailFieldValue = ""
    @Published var passwordFieldValue = ""
    @Published var firstnameFieldValue = ""
    @Published var lastnameFieldValue = ""
    @Published var validationErrorMessage = ""
    @Published var fieldsValid = false
    @Published var isAuthenticated = false
    @Published var authError: String?
    @Published var alert: AppAlert?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func validateCredentials() {
        
        let emailFieldValid = validator.isEmailValid(emailFieldValue)
        let passwordFieldValid = validator.isPasswordValid(passwordFieldValue)
        let firstnameFieldValid = validator.isNameValid(firstnameFieldValue)
        let lastnameFieldValid = validator.isNameValid(lastnameFieldValue)
        
        if !passwordFieldValid && !emailFieldValid {
            validationErrorMessage = ValidationResult.wrongEmailAndPassword.message
        } else if !passwordFieldValid {
            validationErrorMessage = ValidationResult.wrongPassword.message
        } else if !emailFieldValid {
            validationErrorMessage = ValidationResult.wrongEmail.message
        } else if !firstnameFieldValid || !lastnameFieldValid {
            validationErrorMessage = ValidationResult.wrongNames.message
        } else {
            validationErrorMessage = ValidationResult.none.message
            fieldsValid = true
        }
    }
    
    func signUp() {
        let credentials = SignUpCredentials(
            email: emailFieldValue,
            password: passwordFieldValue,
            firstname: firstnameFieldValue,
            lastname: lastnameFieldValue)
        
        firebaseAuthService
            .registrationPublisher(with: credentials)
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
