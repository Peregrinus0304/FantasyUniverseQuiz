//
//  User.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 24.07.2022.
//

import Foundation
import Combine
import UIKit

final class User: ObservableObject {
    var uid: String
    var email: String?
    var displayName: String?
    var refreshToken: String?
    var profileImageURL: URL?
    var firstName: String?
    var lastName: String?
    var image = UIImage(named: "avatarPlaceholder")
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(uid: String,
         email: String?,
         displayName: String?,
         refreshToken: String?,
         profileImageURL: URL?,
         firstName: String?,
         lastName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.refreshToken = refreshToken
        self.profileImageURL = profileImageURL
        self.firstName = firstName
        self.lastName = lastName
        
        if let url = profileImageURL {
            fetchedImagePublisher(from: url)
                .receive(on: DispatchQueue.main)
                .sink { res in
                    switch res {
                    case .failure(let err):
                            debugPrint(err.localizedDescription)
                    default: break
                    }
                } receiveValue: { [weak self] image in
                    self?.image = image
                }
                .store(in: &subscriptions)
        }
        
    }
    
    private func fetchedImagePublisher(from url: URL) -> AnyPublisher<UIImage, AuthError> {
        Deferred {
            Future { promise in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        promise(.success(image))
                    } else {
                        promise(.failure(.cantDownloadImage))
                    }
                } else {
                    promise(.failure(.cantDownloadImage))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
