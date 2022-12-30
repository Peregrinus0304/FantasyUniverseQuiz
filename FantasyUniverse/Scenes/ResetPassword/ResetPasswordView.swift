//
//  ResetPasswordView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.07.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @StateObject private var viewModel = ResetPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        AnimatedBackground(animationName: "day-background") {
            GeometryReader { reader in
                let animationSideSize = reader.size.width - 20
                ScrollView {
                    VStack {
                        Spacer()
                        successAnimation
                            .frame(width: animationSideSize,
                                   height: animationSideSize,
                                   alignment: .center)
                        infoLabel
                            .frame(width: animationSideSize,
                                   alignment: .center)
                        emailField
                        submitButton
                        errorMessage
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
        
        // TODO: Make alert work directly with associated value.

        .alert(item: $viewModel.state.alert) { value in
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
    
    private var successAnimation: some View {
        Group {
            switch viewModel.state {
            case .success:
                    LottieView(animationName: "ok",
                               loopMode: .playOnce,
                               contentMode: .scaleToFill)
            default: EmptyView()
            }
        }
    }
    
    private var infoLabel: some View {
        Group {
            switch viewModel.state {
            case .success:
                    Text("The link was sent to your email")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
            default:
                    EmptyView()
            }
        }
    }
    
    private var submitButton: some View {
        Button(viewModel.state == .success ? "Go back" : "Reset password") {
            switch viewModel.state {
            case .success:
                    self.presentationMode.wrappedValue.dismiss()
            case .validated:
                    viewModel.resetPassword()
            default: return
            }
        }
        .appLabelStyle(style: .light, width: 200, height: UIValues.defaultMinorElementHeight)
    }
    
    private var errorMessage: some View {
        ErrorView(type: .warning, text: $viewModel.validationErrorMessage)
            .padding(UIValues.defaultPadding)
    }
    
}
