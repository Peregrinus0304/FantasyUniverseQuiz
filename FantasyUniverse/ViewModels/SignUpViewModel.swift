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
    @Published var isAuthenticated = false
    @Published var authError: String?
    @Published var alert: AppAlert?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func validateCredentials() -> (areValid: Bool, erorrMassage: String?) {
        
        let emailFieldValid = validator.isEmailValid(emailFieldValue)
        let passwordFieldValid = validator.isPasswordValid(passwordFieldValue)
        let firstnameFieldValid = validator.isNameValid(firstnameFieldValue)
        let lastnameFieldValid = validator.isNameValid(lastnameFieldValue)
        
        var validationError: String? {
            if !passwordFieldValid && !emailFieldValid {
                return "Email and password do not fulfil requirements"
            } else if !passwordFieldValid {
                return "Password does not fulfil requirements"
            } else if !emailFieldValid {
                return "Email does not fulfil requirements"
            } else if !firstnameFieldValid || !lastnameFieldValid {
                return "Either your firstname or lastname do not fulfil requirements"
            } else {
                return nil
            }
        }
        return (emailFieldValid && passwordFieldValid, validationError)
    }
    
    func signUp() {
        let credentials = SignUpCredentials(
            email: emailFieldValue,
            password: passwordFieldValue,
            firstname: firstnameFieldValue,
            lastname: lastnameFieldValue)
        
        firebaseAuthService
            .registrationPublisher(with: credentials)
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
