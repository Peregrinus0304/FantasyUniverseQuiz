//
//  FirebaseAuthService.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 17.05.2022.
//

import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI
import Combine
import UIKit

enum AuthState {
    case failed(with: AuthError)
    case success(with: User)
    case proccessing
    case unauthenticated
}

final class FirebaseAuthService: ObservableObject {
    
    @Published var state: AuthState = .unauthenticated
    
    private var handle: AuthStateDidChangeListenerHandle?
    private var currentUserUID: String?
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        listen()
    }
    
    func listen () {
        // monitor authentication changes using firebase
        state = .proccessing
        handle = Auth
            .auth()
            .addStateDidChangeListener { [weak self] (_, user) in
                guard let self = self else { return }
                if let user = user {
                    
                    self.fetchedUserInfoPublisher(uid: user.uid)
                        .receive(on: RunLoop.main)
                        .sink { res in
                            switch res {
                            case .failure(let err):
                                    debugPrint(err.localizedDescription)
                                    self.state = .failed(with: err)
                                    self.signOut()
                            default: break
                            }
                        } receiveValue: { userInfo in
                            let user = User(
                                uid: user.uid,
                                email: user.email,
                                displayName: user.displayName,
                                refreshToken: user.refreshToken,
                                profileImageURL: user.photoURL,
                                firstName: userInfo.firstname,
                                lastName: userInfo.lastname)
                            self.state = .success(with: user)
                            self.currentUserUID = user.uid
                        }
                        .store(in: &self.subscriptions)
                } else {
                    self.state = .unauthenticated
                    self.currentUserUID = nil
                }
            }
    }
    
    // MARK: - Interface
    
    func loginPublisher(with credentials: ManualSignInCredentials) -> AnyPublisher<Void, AuthError> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .signIn(withEmail: credentials.email,
                            password: credentials.password) { _, err in
                        if let error = err {
                            self.state = .failed(with: .otherError(error))
                            promise(.failure(.otherError(error)))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func registrationPublisher(with credentials: SignUpCredentials) -> AnyPublisher<Void, AuthError> {
        
        Deferred {
            Future<String, AuthError> { promise in
                Auth
                  .auth()
                  .createUser(
                     withEmail: credentials.email,
                     password: credentials.password) { res, err in
                        if let error = err {
                            promise(.failure(.otherError(error)))
                        } else {
                            if let uid = res?.user.uid {
                                promise(.success(uid))
                            } else {
                                promise(.failure(.noUser))
                            }
                        }
                    }
            }
        }
        .flatMap { [weak self] uid in
            self?.storeUserInfoPublisher(
                uid: uid,
                firstname: credentials.firstname,
                lastname: credentials.lastname) ??
            Fail<Void, AuthError>(error: AuthError.noUser) .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    func resetPasswordPublisher(with email: String) -> AnyPublisher<Void, AuthError> {
        Deferred {
            Future { promise in
                Auth
                  .auth()
                  .sendPasswordReset(
                    withEmail: email,
                    completion: { err in
                        if err != nil {
                            promise(.failure(.cantResetPassword))
                        } else {
                            promise(.success(()))
                        }
                    })
            }
        }
        .eraseToAnyPublisher()
    }
      
    func uploadProfileImagePublisher(_ image: UIImage) -> AnyPublisher<Void, AuthError> {
        Deferred {
            Future { promise in
                if let uid = self.currentUserUID {
                    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                        promise(.failure(.cantCompressImage))
                        return
                    }
                    let storageRef = Storage.storage().reference()
                    let imagesStorageRef = storageRef.child(AuthFirebaseKeys.images.rawValue).child(uid)
                    imagesStorageRef.putData(imageData, metadata: nil) { (metadata, error) in
                        guard metadata != nil else {
                            promise(.failure(.cantUploadImage))
                            return
                        }
                        
                        guard error == nil else {
                            promise(.failure(.otherError(error!)))
                            return
                        }
                        
                        imagesStorageRef.downloadURL { (url, error) in
                            guard error == nil else {
                                promise(.failure(.otherError(error!)))
                                return
                            }
                            
                            guard let downloadURL = url else {
                                promise(.failure(.imageURLNotFound))
                                return
                            }
                            
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.photoURL = downloadURL
                            changeRequest?.commitChanges { error in
                                if let error = error {
                                    promise(.failure(.otherError(error)))
                                } else {
                                    promise(.success(()))
                                }
                            }
                        }
                    }
                } else {
                    promise(.failure(.noUser))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.state = .unauthenticated
        } catch {
            self.state = .failed(with: .cantSignOut)
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
            self.state = .unauthenticated
        }
    }
    
    // MARK: - Private methods
    
    private func fetchedUserInfoPublisher(uid: String) -> AnyPublisher<UserInfo, AuthError> {
        Deferred {
            Future<UserInfo, AuthError> { promise in
                Firestore
                    .firestore()
                    .collection(AuthFirebaseKeys.users.rawValue)
                    .document(uid)
                    .getDocument { (snap, err) in
                        guard err == nil else {
                            promise(.failure(.otherError(err!)))
                            return
                        }
                        guard let data = snap else {
                            promise(.failure(.noDataReceived))
                            return
                        }
                        guard let decodedBook = try? data.data(as: UserInfo.self) else {
                            promise(.failure(.noDataReceived))
                            return
                        }
                        promise(.success(decodedBook))
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func storeUserInfoPublisher(uid: String, firstname: String?, lastname: String?) -> AnyPublisher<Void, AuthError> {
        let userDataDict = [
            AuthFirebaseKeys.firstname.rawValue: firstname,
            AuthFirebaseKeys.lastname.rawValue: lastname] as [String : Any]
        return Deferred {
            Future<Void, AuthError> { promise in
                Firestore
                    .firestore()
                    .collection(AuthFirebaseKeys.users.rawValue)
                    .document(uid)
                    .setData(userDataDict, merge: true) { error in
                        if let err = error {
                            promise(.failure(.otherError(err)))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
}
