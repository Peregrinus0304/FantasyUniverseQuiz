//
//  ResetPasswordViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.07.2022.
//

import Foundation
import Combine

class ResetPasswordViewModel: ObservableObject {
    
    enum State: Equatable {
        case idle
        case validated
        case error(AppAlert)
        case success
        
        var alert: AppAlert? {
            get {
                switch self {
                case let .error(alert): return alert
                default: return nil
                }
            }
            set {
                if let newValue = newValue {
                    switch self {
                    case .error: self = .error(newValue)
                    default: return
                    }
                }
            }
        }
    }
    
    private let validator = AuthenticationValidator()
    private let firebaseAuthService = FirebaseAuthService()
    @Published var emailFieldValue = ""
    @Published var validationErrorMessage = ""
    
    @Published var state: State = .idle
    
    private var subscriptions = Set<AnyCancellable>()
    
    func validateCredentials() {
        let emailFieldValid = validator.isEmailValid(emailFieldValue)
        if !emailFieldValid {
            validationErrorMessage = ValidationResult.wrongEmail.message
        } else {
            validationErrorMessage = ValidationResult.none.message
            state = .validated
        }
    }
    
    func resetPassword() {
        firebaseAuthService
            .resetPasswordPublisher(with: emailFieldValue)
            .sink { res in
                switch res {
                case .failure(let err):
                    self.state = .error(.authError(message: err.localizedDescription))
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .success
            }
            .store(in: &subscriptions)
    }
}
