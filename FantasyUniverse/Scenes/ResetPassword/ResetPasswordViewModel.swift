//
//  ResetPasswordViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.07.2022.
//

import Foundation
import Combine

class ResetPasswordViewModel: ObservableObject {
    
    private let validator = AuthenticationValidator()
    private let firebaseAuthService = FirebaseAuthService()
    @Published var emailFieldValue = ""
    @Published var validationErrorMessage = ""
    @Published var fieldsValid = false
    @Published var isResetSuccessfull = false
    @Published var authError: String?
    @Published var alert: AppAlert?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func validateCredentials() {
        let emailFieldValid = validator.isEmailValid(emailFieldValue)
            if !emailFieldValid {
                validationErrorMessage = ValidationResult.wrongEmail.message
            } else {
                validationErrorMessage = ValidationResult.none.message
                fieldsValid = true
            }
    }
    
    func resetPassword() {
        firebaseAuthService
            .resetPasswordPublisher(with: emailFieldValue)
            .sink { res in
                switch res {
                case .failure(let err):
                    self.alert = .authError(message: err.localizedDescription)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.isResetSuccessfull = true
            }
            .store(in: &subscriptions)
    }
}
