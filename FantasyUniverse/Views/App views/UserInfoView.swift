//
//  UserInfoView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 31.07.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    var user: User
    var userImageName: String?
    let logoutAction: () -> Void
    let editProfileAction: () -> Void
    let imageTappedAction: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            HStack {
                infoList
                    .padding([.vertical, .leading], 3)
                    .frame(width: (reader.size.width / 2) - 6)
                VStack {
                    userTappableImage
                    HStack {
                        logoutButton
                        editProfileButton
                    }
                }
                .padding([.vertical, .trailing], 3)
                .frame(width: (reader.size.width / 2) - 6)
            }
            .background(Color(Asset.Colors.appLint.color))
        }
    }
    
    private var infoList: some View {

            VStack {
                InfoCell(name: "Display name:", value: user.displayName)
                InfoCell(name: "Email:", value: user.email)
                Spacer()
            }
            .padding(.top, 3)
    }
    
    private var userTappableImage: some View {
        Button {
            imageTappedAction()
        } label: {
            Image(systemName: "person")

                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .padding(3)
        }
        .cornerRadius(UIValues.defaultCornerRadius)
        .overlay(
            RoundedRectangle(
                cornerRadius: UIValues.defaultCornerRadius)
                .stroke(Color(Asset.Colors.appBlue.color),
                        lineWidth: UIValues.defaultBorderWidth)
        )
    }
    
    private var editProfileButton: some View {
        Button("Edit Profile") {
            editProfileAction()
        }
        .appSystemButtonStyle(type: .normal, height: 50)
    }
    
    private var logoutButton: some View {
        Button("Log out") {
            logoutAction()
        }
        .appSystemButtonStyle(type: .destructive, height: 50)

    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(user: User(uid: "", displayName: "User", email: "Email", refreshToken: ""), userImageName: "") {
            print("logoutAction")
        } editProfileAction: {
            print("editProfileAction")
        } imageTappedAction: {
            print("editProfileAction")
        }
        
    }
}
