//
//  AuthenticationValidator.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.04.2022.
//

import Foundation

public class AuthenticationValidator {
    let isEmailValid: (String?) -> (Bool) = { (email: String?) -> (Bool) in
        let emailPred = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: email)
    }
    
    let isPasswordValid: (String?) -> (Bool) = { (password: String?) -> (Bool) in
        let passwordPred = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$&*]).{8}$")
        return passwordPred.evaluate(with: password)
    }
    
    let isNameValid: (String?) -> (Bool) = { (name: String?) -> (Bool) in
        let namePred = NSPredicate(format: "SELF MATCHES %@ ", "^[A-Za-z]{2,32}$")
        return namePred.evaluate(with: name)
    }
}
