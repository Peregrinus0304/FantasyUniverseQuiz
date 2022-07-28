//
//  AppAlert.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.07.2022.
//

import SwiftUI

enum AppAlert: Identifiable {
    
    case authError(message: String? = nil)
    
    case unnamedAlert(title: String,
                      message: String? = nil,
                      primaryButton: Alert.Button,
                      secondaryButton: Alert.Button)
    
    var alert: Alert {
        switch self {
        case .authError(message: let message):
            
            return Alert(title: Text("Authentication failed"),
                         message: message != nil ? Text(message!) : nil)
            
        case .unnamedAlert(title: let title,
                         message: let message,
                         primaryButton: let primaryButton,
                         secondaryButton: let secondaryButton):
            
            return Alert(title: Text(title),
                         message: message != nil ? Text(message!) : nil,
                         primaryButton: primaryButton,
                         secondaryButton: secondaryButton)
        }
    }
    
    var id: String {
        switch self {
        case .authError:
            return "authError"
        case .unnamedAlert:
            return "unnamedAlert"
        }
    }
    
}
