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
        GeometryReader { rect in
            let animationSideSize = rect.size.width - 20
            ZStack {
                Color.gray
                VStack {
                    Spacer()
                    successAnimation
                        .frame(width: animationSideSize,
                               height: animationSideSize,
                               alignment: .center)
                    infoLabel
                        .frame(width: animationSideSize,
                               height: 30,
                               alignment: .center)
                    emailField
                    submitButton
                    errorMessage
                }
                .navigationBarTitle("Reset password")
                .padding(.vertical, 20)
                .alert(item: $viewModel.alert) { value in
                    return value.alert
                }
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
        Button {
            if viewModel.isResetSuccessfull {
                self.presentationMode.wrappedValue.dismiss()
            } else {
                if viewModel.validateCredentials().areValid {
                    viewModel.resetPassword()
                } else {
                    viewModel.errorMessage = viewModel.validateCredentials().erorrMassage!
                }
            }
        } label: {
            Text(viewModel.isResetSuccessfull ? "Go back" : "Reset password")
                .bold()
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    private var errorMessage: some View {
        Text(viewModel.errorMessage)
            .foregroundColor(.red)
            .fontWeight(.bold)
    }
    
}
