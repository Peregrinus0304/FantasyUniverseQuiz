//
//  FirebaseAuthService.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 17.05.2022.
//

import FirebaseAuth
import Firebase
import Combine

enum AuthState {
    case failed(with: Error)
    case success(with: User)
    case proccessing
    case unauthenticated
}

final class FirebaseAuthService: ObservableObject {

    @Published var state: AuthState = .unauthenticated
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listen()
    }
    
    func listen () {
        // monitor authentication changes using firebase
        state = .proccessing
        handle = Auth
            .auth()
            .addStateDidChangeListener { (_, user) in
                if let user = user {
                    print("Got user: \(user)")
                    
                   let user = User(
                        uid: user.uid,
                        displayName: user.displayName,
                        email: user.email,
                        refreshToken: user.refreshToken)
                    self.state = .success(with: user)
                } else {
                    self.state = .unauthenticated
                }
            }
    }
    
    func loginPublisher(with credentials: ManualSignInCredentials) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .signIn(withEmail: credentials.email,
                            password: credentials.password) { _, err in
                        if let error = err {
                            self.state = .failed(with: error)
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func registrationPublisher(with credentials: SignUpCredentials) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .createUser(withEmail: credentials.email,
                                password: credentials.password) { res, err in
                        if let error = err {
                            promise(.failure(error))
                        } else {
                            if let uid = res?.user.uid {
                                let values = [
                                    AuthFirebaseKeys.firstname.rawValue:
                                        credentials.firstname,
                                    AuthFirebaseKeys.lastname.rawValue: credentials.lastname] as [String: Any]
                                
                                Database
                                    .database()
                                    .reference()
                                    .child(AuthFirebaseKeys.users.rawValue)
                                    .child(uid)
                                    .updateChildValues(values) { error, _ in
                                        if let err = error {
                                            promise(.failure(err))
                                        } else {
                                            promise(.success(()))
                                        }
                                    }
                                
                            } else {
                                promise(.failure(NSError(domain: "Invalid User Id", code: 0, userInfo: nil)))
                            }
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func resetPasswordPublisher(with email: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth
                    .auth()
                    .sendPasswordReset(withEmail: email, completion: { err in
                        if let error = err {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    })
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.state = .unauthenticated
        } catch {
            self.state = .failed(with: error)
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
            self.state = .unauthenticated
        }
    }
}
