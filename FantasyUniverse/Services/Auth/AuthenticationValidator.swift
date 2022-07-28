//
//  AuthenticationValidator.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.04.2022.
//

import Foundation

public class AuthenticationValidator {
    let isEmailValid: (String?) -> (Bool) = { (email: String?) -> (Bool) in
        // The email should contain:
        // The prefix containing alphanumeric signs or underscore, "-" character or perion sign - [\\w-\\.],
        // followed by a @ sign - "+@",
        // followed by a suffix, containing alphanumeric signs, underscore or "-" character - [\\w-\\],
        // a period sign - "+\\.",
        // the ending that alphanumeric signs or underscore - [\\w-]
        // and the length should be in a range of 6-18 signs.
        let emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@",
                                    emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    let isPasswordValid: (String?) -> (Bool) = { (password: String?) -> (Bool) in
        // The password should contain at least:
        // one uppercase letter - (?=.*[A-Z]),
        // one special sign - (?=.*[!@#$&*]),
        // one numeric sign - (?=.*[0-9]),
        // one lowercase letter - (?=.*[a-z]),
        // and the length should be at least 6 signs.
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@",
                                       passwordRegex)
        return passwordPred.evaluate(with: password)
    }
    
    let isNameValid: (String?) -> (Bool) = { (name: String?) -> (Bool) in
        // The name should contain:
        // only alphabetic signs - [A-Za-z],
        // the length should be in a range of 2-10 signs.
        let nameRegex = "^[A-Za-z]{2,10}$"
        let namePred = NSPredicate(format: "SELF MATCHES %@",
                                   nameRegex)
        return namePred.evaluate(with: name)
    }
}
