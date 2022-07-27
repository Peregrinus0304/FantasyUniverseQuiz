//
//  SignUpView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 14.05.2022.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            Color.gray
            VStack {
                Spacer()
                emailField
                passwordField
                firstnameField
                lastnameField
                Spacer()
                submitButton
                navigation
                errorMessage
            }
            .navigationBarTitle("Sign up")
            .padding(.all, 50)
            .alert(item: $viewModel.alert) { value in
                return value.alert
            }
        }
    }
    
    private var emailField: some View {
        CredentialsInputView(
            labelText: "Email",
            textFieldPlaceholder: "Type your email",
            isSecure: false,
            textFieldContent: $viewModel.emailFieldValue)
    }
    
    private var passwordField: some View {
        CredentialsInputView(
            labelText: "Password",
            textFieldPlaceholder: "Type your password",
            isSecure: true,
            textFieldContent: $viewModel.passwordFieldValue)
    }
    
    private var firstnameField: some View {
        CredentialsInputView(
            labelText: "Firstname",
            textFieldPlaceholder: "Type your firstname",
            isSecure: true,
            textFieldContent: $viewModel.firstnameFieldValue)
    }
    
    private var lastnameField: some View {
        CredentialsInputView(
            labelText: "Lastname",
            textFieldPlaceholder: "Type your lastname",
            isSecure: true,
            textFieldContent: $viewModel.lastnameFieldValue)
    }
    
    private var submitButton: some View {
        Button {
            if viewModel.validateCredentials().areValid {
                viewModel.signUp()
            } else {
                viewModel.validationErrorMessage = viewModel.validateCredentials().erorrMassage!
            }
        } label: {
            Text("Sign up")
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
