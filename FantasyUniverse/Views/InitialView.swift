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

            AnimatedBackground(animationName: "day-background") {
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
        .appNavigationViewStyle()
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
                .defaultLabelStyle(width: 300, height: 50)
        }
    }
   
    var signUpButton: some View {
        NavigationLink {
            SignUpView()
        } label: {
            Text("Sign up")
                .defaultLightLabelStyle(width: 300, height: 50)
        }
    }
    
    var restorePasswordButton: some View {
        NavigationLink {
            ResetPasswordView()
        } label: {
            Text("Restore my password")
                .defaultDarkLabelStyle(width: 300, height: 50)
        }
    }
    
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
