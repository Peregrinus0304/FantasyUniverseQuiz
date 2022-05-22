//
//  FirebaseAuthService.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 17.05.2022.
//

import Foundation
import FirebaseAuth
import Firebase

class FirebaseAuthService {
    
    func createUser(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        debugPrint("Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
                    case .emailAlreadyInUse:
                        debugPrint("Error: The email address is already in use by another account.")
                    case .invalidEmail:
                        debugPrint("Error: The email address is badly formatted.")
                    case .weakPassword:
                        debugPrint("Error: The password must be 6 characters long or more.")
                    default:
                        debugPrint("Error: \(error.localizedDescription)")
                }
                completion(false)
            } else {
                print(authResult?.user ?? "Firebase Sign up failed")
                
                completion(true)
            }
        }
    }
    
    func storeUserInfo(name: String, surname: String) {
        
        if userLoggedIn() {
            let ref = Database.database().reference()
            
            let userData = ["firstName": name,
                            "lastName": surname]
            ref.child("users").child(Auth.auth().currentUser!.uid).setValue(userData)
            
        } else {
            debugPrint("Error: Trying to store user info for signed out user")
        }
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        debugPrint("Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
                    case .userDisabled:
                        debugPrint("Error: The user account has been disabled by an administrator.")
                    case .wrongPassword:
                        debugPrint("Error: The password is invalid or the user does not have a password.")
                    case .invalidEmail:
                        debugPrint("Error: Indicates the email address is malformed.")
                    default:
                        debugPrint("Error: \(error.localizedDescription)")
                }
                completionBlock(false)
                
            } else {
                print(result?.user.email)
                completionBlock(true)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign out error")
        }
    }
    
    func userLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func resetPassword(email: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                    case .userNotFound:
                        debugPrint("Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
                        
                    case .invalidEmail:
                        debugPrint("Error: The email address is badly formatted.")
                    case .invalidRecipientEmail:
                        debugPrint("Error: Indicates an invalid recipient email was sent in the request.")
                        
                    case .invalidSender:
                        debugPrint("Error: Indicates an invalid sender email is set in the console for this action.")
                        
                    case .invalidMessagePayload:
                        debugPrint("Error: Indicates an invalid email template for sending update email.")
                    default:
                        debugPrint("Error message: \(error.localizedDescription)")
                }
                completionBlock(false)
            } else {
                print("Reset password email has been successfully sent")
                completionBlock(true)
            }
        }
    }
}
