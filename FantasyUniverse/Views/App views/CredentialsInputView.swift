//
//  CredentialsInputView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 14.05.2022.
//

import SwiftUI

struct CredentialsInputView: View {
    
    var labelText: String
    var textFieldPlaceholder: String
    var isSecure: Bool
    @Binding var textFieldContent: String
    
    var body: some View {
        Text(labelText)
            .bold()
            .foregroundColor(.blue)
        
        Group {
            if isSecure {
                SecureField(
                    textFieldPlaceholder,
                    text: $textFieldContent
                )
            } else {
                TextField(
                    textFieldPlaceholder,
                    text: $textFieldContent
                )
            }
        }
        .textFieldStyle(AppStandardTextFieldStyle())
        .padding()
    }
}

struct CredentialsInputView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsInputView(labelText: "cdcdc", textFieldPlaceholder: "dcdcdd", isSecure: true, textFieldContent: .constant(""))
    }
}
