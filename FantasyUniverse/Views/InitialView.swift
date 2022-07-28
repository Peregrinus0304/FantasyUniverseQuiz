//
//  InitialView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.07.2022.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        NavigationView {

        ZStack {
            Color.gray
            VStack {
                logoAnimation
                signInButton
                signUpButton
                restorePasswordButton
            }
            .padding(.vertical, 25)
        }
        .ignoresSafeArea()
        }
    }
    
    var logoAnimation: some View {
        LottieView(animationName: "intro-logo",
                   loopMode: .playOnce,
                   contentMode: .scaleAspectFit)
    }
    
    var signInButton: some View {
        NavigationLink {
            ManualSignInView()
        } label: {
            Text("Sign in")
                .bold()
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
   
    var signUpButton: some View {
        NavigationLink {
            SignUpView()
        } label: {
            Text("Sign up")
                .bold()
                .frame(width: 200, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    var restorePasswordButton: some View {
        NavigationLink {
            ResetPasswordView()
        } label: {
            Text("Restore my password")
                .bold()
                .frame(width: 200, height: 50)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
