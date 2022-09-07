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
        AnimatedBackground(animationName: "day-background") {
            GeometryReader { reader in
                ScrollView {
                    VStack {
                        emailField
                        passwordField
                        firstnameField
                        lastnameField
                        errorMessage
                        submitButton
                        navigation
                    }
                    .frame(minHeight: reader.size.height)
                    .keyboardAwarePadding()
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarTitle("Sign up")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            self.endTextEditing()
        }
        .alert(item: $viewModel.alert) { value in
            return value.alert
        }
    }
    
    private var emailField: some View {
        CredentialsInputField(
            labelText: "Email",
            textFieldPlaceholder: "Type your email",
            textFieldValue: $viewModel.emailFieldValue, valueModified: {
                viewModel.validateCredentials()
            })
    }
    
    private var passwordField: some View {
        CredentialsInputField(
            labelText: "Password",
            textFieldPlaceholder: "Type your password",
            textFieldValue: $viewModel.passwordFieldValue, valueModified: {
                viewModel.validateCredentials()
            })
    }
    
    private var firstnameField: some View {
        CredentialsInputField(
            labelText: "Firstname",
            textFieldPlaceholder: "Type your firstname",
            textFieldValue: $viewModel.firstnameFieldValue, valueModified: {
                viewModel.validateCredentials()
            })
    }
    
    private var lastnameField: some View {
        CredentialsInputField(
            labelText: "Lastname",
            textFieldPlaceholder: "Type your lastname",
            textFieldValue: $viewModel.lastnameFieldValue, valueModified: {
                viewModel.validateCredentials()
            })
    }
    
    private var submitButton: some View {
        
        Button("Sign up") {
            if viewModel.fieldsValid {
                viewModel.signUp()
            }
        }
        .appSystemButtonStyle(type: .normal)
    }
    
    private var errorMessage: some View {
        ErrorView(type: .warning, text: $viewModel.validationErrorMessage)
            .padding(.horizontal, UIValues.defaultPadding)
    }
    
    private var navigation: some View {
        NavigationLink(
            destination: DashboardView(),
            isActive: $viewModel.isAuthenticated) {
                EmptyView()
            }
    }
}
