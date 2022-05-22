//
//  ManualSighInView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.04.2022.
//

import SwiftUI

struct ManualSignInView: View {
    
    @ObservedObject var viewModel = ManualSignInViewModel()
    @AppStorage("email") var username: String = ""
    @State private var loginFieldValue = ""
    @State private var passwordFieldValue = ""
    @State private var errorMessage = ""
    @State private var isAuthenticated = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Spacer()
                
                CredentialsInputView(labelText: "Login", textFieldPlaceholder: "Type your login", isSecure: false, textFieldContent: $loginFieldValue)
              
                CredentialsInputView(labelText: "Password", textFieldPlaceholder: "Type your password", isSecure: true, textFieldContent: $passwordFieldValue)
                
                Spacer()
                Button {
                    if checkCredentials().0 {
                        signIn()
                    } else {
                        errorMessage = checkCredentials().1!
                    }
  
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: DashboardView(), isActive: $isAuthenticated) {
                    EmptyView()
                }
                
                Text(errorMessage)
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
            .navigationBarTitle("Sign in")
            .padding(.all, 50)
            
        }
        
    }
    
    private func checkCredentials() -> (Bool, String?) {
        let credentials = ManualSignInCredentials(email: loginFieldValue, password: passwordFieldValue)
        let validationResult = viewModel.credentialsAreValid(credentials)
       
        return validationResult
    }
    
    private func signIn() {
        let credentials = ManualSignInCredentials(email: loginFieldValue, password: passwordFieldValue)

        viewModel.signIn(with: credentials) { success in
            if success {
                print("Signed in successful")
                username = credentials.email
                isAuthenticated = true
            } else {
                errorMessage = "Error while authenticating"
            }
        }
        
    }
}
