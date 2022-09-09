//
//  UserViewModel.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 27.07.2022.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class UserViewModel: ObservableObject {
    
    @Published var alert: AppAlert?
    @Published var selectedImage: Image?
    
    private let firebaseAuthService = FirebaseAuthService()
    private var subscriptions = Set<AnyCancellable>()
    
    func signOut() {
        firebaseAuthService
            .signOut()
    }
    
    func loadProfileImage(for user: User) {
        DispatchQueue.main.async {
            if let image = user.image {
                self.selectedImage = Image(uiImage: image)
            }
        }
    }
    
    func updateProfileImage(image: UIImage) {
        firebaseAuthService
            .uploadProfileImagePublisher(image)
            .receive(on: RunLoop.main)
            .sink { res in
                switch res {
                case .failure(let err):
                        self.alert = .authError(message: err.localizedDescription)
                default: break
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
    }
}
