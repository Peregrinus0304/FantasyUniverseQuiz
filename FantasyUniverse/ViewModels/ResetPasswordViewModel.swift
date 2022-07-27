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
    @Published var errorMessage = ""
    @Published var isResetSuccessfull = false
    @Published var authError: String?
    @Published var alert: AppAlert?
    
    private var subscriptions = Set<AnyCancellable>()
    
    func validateCredentials() -> (areValid: Bool, erorrMassage: String?) {
        let emailFieldValid = validator.isEmailValid(emailFieldValue)
        var validationError: String? {
            if !emailFieldValid {
                return "Email does not fulfil requirements"
            } else {
                return nil
            }
        }
        return (emailFieldValid, validationError)
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
