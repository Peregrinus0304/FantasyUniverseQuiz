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
        
        AnimatedBackground(animationName: "day-background") {
            GeometryReader { reader in
                ScrollView {
                    VStack {
                        Spacer()
                        loginField
                        passwordField
                        Spacer()
                        errorMessage
                        submitButton
                        navigation
                        Spacer()
                    }
                    .frame(minHeight: reader.size.height)
                    .keyboardAwarePadding()
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarTitle("Sign in")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            self.endTextEditing()
        }
        .alert(item: $viewModel.alert) { value in
            return value.alert
        }
        
    }
    
    private var loginField: some View {
        CredentialsInputField(
            labelText: "Login",
            textFieldPlaceholder: "Type your login",
            textFieldValue: $viewModel.loginFieldValue, valueModified: {
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
    
    private var submitButton: some View {
        Button("Sign in") {
            if viewModel.fieldsValid {
                viewModel.signIn()
            }
            
        }
        .buttonStyle(AppNextButton())
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
