//
//  AuthError.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 22.08.2022.
//

import Foundation

enum AuthError: Error {
    case invalidPassword
    case noUser
    case cantCompressImage
    case cantUploadImage
    case cantDownloadImage
    case cantSignOut
    case imageURLNotFound
    case noDataReceived
    case cantResetPassword
    
    // all other cases
    case otherError(Error)
    
}

extension AuthError: LocalizedError {
    public var description: String {
        switch self {
        case .invalidPassword:
                return "The provided password is not valid."
        case .noUser:
                return "There is no signed in user found"
        case .cantCompressImage:
                return "The image You have selected can`t be compresed"
        case .cantUploadImage:
                return "The image You have selected can`t be uploaded"
        case .cantDownloadImage:
                return "The image can`t be downloaded"
        case .imageURLNotFound:
                return "The URL of your image has not been found"
        case .noDataReceived:
                return "No data received from the remote database"
        case .cantSignOut:
                return "Some problems occured while signing out the user"
        case .cantResetPassword:
                return "Can`t send restore password request"
        case .otherError(let error):
                return error.localizedDescription
        }
    }
}
