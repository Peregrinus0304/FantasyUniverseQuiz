//
//  SignUpView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 14.05.2022.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    
    @State private var firstNameFieldValue = ""
    @State private var lastNameFieldValue = ""
    @State private var loginFieldValue = ""
    @State private var passwordFieldValue = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                CredentialsInputView(labelText: "Name", textFieldPlaceholder: "Type your name", isSecure: false, textFieldContent: $firstNameFieldValue)
                CredentialsInputView(labelText: "Surname", textFieldPlaceholder: "Type your surname", isSecure: false, textFieldContent: $lastNameFieldValue)
                CredentialsInputView(labelText: "Email", textFieldPlaceholder: "Type your email", isSecure: false, textFieldContent: $loginFieldValue)
                CredentialsInputView(labelText: "Password", textFieldPlaceholder: "Type your password", isSecure: true, textFieldContent: $passwordFieldValue)
                Spacer()
                NavigationLink(destination: DashboardView(), label: {
                    Text("Sign up")
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }).disabled(!checkCredentials())
            }
            .navigationBarTitle("Sign up")
            .padding(.all, 50)
            
        }
        
    }
    
    private func checkCredentials() -> Bool {
        let credentials = ManualSignInCredentials(email: loginFieldValue, password: passwordFieldValue)
        return viewModel.credentialsAreValid(credentials)
    }
}
