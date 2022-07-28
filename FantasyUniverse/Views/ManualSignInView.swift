//
//  ManualSighInView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.04.2022.
//

import SwiftUI

struct ManualSignInView: View {
    
    @StateObject var viewModel = ManualSignInViewModel()
    
    var body: some View {
        ZStack {
            Color.gray
            VStack {
                Spacer()
                loginField
                passwordField
                Spacer()
                submitButton
                navigation
                errorMessage
            }
            .navigationBarTitle("Sign in")
            .padding(.all, 50)
            .alert(item: $viewModel.alert) { value in
                return value.alert
            }
        }
    }
    
    private var loginField: some View {
        CredentialsInputView(
            labelText: "Login",
            textFieldPlaceholder: "Type your login",
            isSecure: false,
            textFieldContent: $viewModel.loginFieldValue)
    }
    
    private var passwordField: some View {
        CredentialsInputView(
            labelText: "Password",
            textFieldPlaceholder: "Type your password",
            isSecure: true,
            textFieldContent: $viewModel.passwordFieldValue)
    }
    
    private var submitButton: some View {
        Button {
            if viewModel.validateCredentials().areValid {
                viewModel.signIn()
            } else {
                viewModel.validationErrorMessage = viewModel.validateCredentials().erorrMassage!
            }
        } label: {
            Text("Sign in")
                .bold()
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    private var errorMessage: some View {
        Text(viewModel.validationErrorMessage)
            .foregroundColor(.red)
            .fontWeight(.bold)
    }
    
    private var navigation: some View {
        NavigationLink(
            destination: DashboardView(),
            isActive: $viewModel.isAuthenticated) {
                EmptyView()
            }
    }
}
