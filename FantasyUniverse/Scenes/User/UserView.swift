//
//  AccountView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.07.2022.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var user: User
    @StateObject var viewModel = UserViewModel()
    @State var progressPlaceholder: Float = 0.1   // TODO: To be delated.
    @State var animating = false
    
    var body: some View {
        GeometryReader { reader in
            
            VStack {
                profileInfoView
                    .frame(height: reader.size.height/2)
                    .offset(x: animating ? 0 : -reader.size.width, y: 0)
                    .overlay(
                        Rectangle()
                            .frame(width: nil,
                                   height: UIValues.minimalBorderWidth,
                                   alignment: .bottom)
                            .foregroundColor(Color(Asset.Colors.navyBlue.color)),
                        alignment: .bottom)
                    .animateWithSpring { animating.toggle() }
                    .onDisappear { animating.toggle() }
                VStack {
                    HStack {
                        CircularProgressView(progress: $progressPlaceholder, width: 150.0, height: 150.0)
                        CircularProgressView(progress: $progressPlaceholder, width: 150.0, height: 150.0)
                    }
                    
                    HStack {
                        CircularProgressView(progress: $progressPlaceholder, width: 150.0, height: 150.0)
                        CircularProgressView(progress: $progressPlaceholder, width: 150.0, height: 150.0)
                    }
                }
               
            }
            .navigationBarTitle("Sign in")
        }
    }
    
    private var profileInfoView: some View {
        UserInfoView(
            user: user,
            userImageName: "nil",
            logoutAction: { viewModel.signOut() },
            editProfileAction: { print("editProfileAction")},
            imageTappedAction: {
                print("imageTappedAction")
                let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
                self.progressPlaceholder += randomValue
            })
            .background(Color(Asset.Colors.appLint.color))
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
