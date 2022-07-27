//
//  AuthenticationValidatorTests.swift
//  FantasyUniverseTests
//
//  Created by TarasPeregrinus on 17.07.2022.
//

import XCTest
@testable import FantasyUniverse

class AuthenticationValidatorTests: XCTestCase {
    
    let authentiationValidator = AuthenticationValidator()
    
    func testPassword_WhenIsNotValid_ShouldReturnFalse() {
        let noLowercasePassword = "P@SSWORD1"
        let noUppercasePassword = "p@ssword1"
        let noSpecialSighPassword = "Password1"
        let noNumericSighPassword = "Password"
        let notEnoughLengthPassword = "Passw"
        
        [noLowercasePassword,
         noUppercasePassword,
         noSpecialSighPassword,
         noNumericSighPassword,
         notEnoughLengthPassword].forEach { invalidPassword in
            XCTAssertFalse(authentiationValidator.isPasswordValid(invalidPassword),
                           "The password: \(invalidPassword) is not valid, but validated as valid one")
        }
    }
    
    func testPassword_WhenIsValid_ShouldReturnTrue() {
        let validPassword = "P@ssword1"
        XCTAssertTrue(authentiationValidator.isPasswordValid(validPassword),
                      "The validation of valid password: \(validPassword) should return true, but returns false")
    }
    
    func testEmail_WhenIsNotValid_ShouldReturnFalse() {
        let emailWithNoPrefix = "@email.com"
        let emailWithNoSuffix = "workingexample@.com"
        let emailWithNoEnding = "workingexample@email."
        let emailWithNoPeriod = "workingexample@emailcom"
        let emailWithSpecialSign = "!@#$&*@!@#$&*.!@#$&*"
        let emailWithNoAtSign = "workingexampleemail.com"
        
        [emailWithNoPrefix,
         emailWithNoSuffix,
         emailWithNoEnding,
         emailWithNoPeriod,
         emailWithSpecialSign,
         emailWithNoAtSign].forEach { invalidEmail in
            XCTAssertFalse(authentiationValidator.isEmailValid(invalidEmail),
                           "The email: \(invalidEmail) is not valid, but validated as valid one")
        }
    }
    func testEmail_WhenIsValid_ShouldReturnTrue() {
        let validEmail = "workingexample@email.com"
        XCTAssertTrue(authentiationValidator.isEmailValid(validEmail),
                      "The validation of valid email: \(validEmail) should return true, but returns false")
    }
    
    func testUsername_WhenIsNotValid_ShouldReturnFalse() {
        let tooShortName = "n"
        let tooLongName = "ElevenSigns"
        let onlyDigitsName = "123"
        
        [tooShortName,
         tooLongName,
         onlyDigitsName].forEach { invalidName in
            XCTAssertFalse(authentiationValidator.isNameValid(invalidName),
                           "The username: \(invalidName) is not valid, but validated as valid one")
        }
    }
    func testUsername_WhenIsValid_ShouldReturnTrue() {
        let validName = "Name"
        XCTAssertTrue(authentiationValidator.isNameValid(validName),
                      "The validation of valid username: \(validName) should return true, but returns false")
    }
    
}
