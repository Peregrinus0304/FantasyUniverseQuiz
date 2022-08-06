//
//  ResetPasswordView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.07.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
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
                                   height: UIValues.defaultInfoLabelHeight,
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
    
    private var successAnimation: some View {
        Group {
            if viewModel.isResetSuccessfull {
                LottieView(animationName: "ok",
                           loopMode: .playOnce,
                           contentMode: .scaleToFill)
            } else {
                EmptyView()
            }
        }
    }
    
    private var infoLabel: some View {
        Group {
            if viewModel.isResetSuccessfull {
                Text("The link was sent to your email")
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            } else {
                EmptyView()
            }
        }
    }
    
    private var submitButton: some View {
        Button(viewModel.isResetSuccessfull ? "Go back" : "Reset password") {
            
            if viewModel.isResetSuccessfull {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                if viewModel.fieldsValid {
                    viewModel.resetPassword()
                }
            }
        }
        .defaultLightLabelStyle(width: 200, height: UIValues.defaultMinorElementHeight)
    }
    
    private var errorMessage: some View {
        ErrorView(type: .warning, text: $viewModel.validationErrorMessage)
            .padding(UIValues.defaultPadding)
    }
    
}
