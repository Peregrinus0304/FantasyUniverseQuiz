//
//  UserInfoView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 31.07.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    var user: User
    @Binding var userImage: Image?
    @State private var showingAvatar = false
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
                        .opacity(showingAvatar ? 1 : 0)
                        .animation(Animation.easeOut(duration: 0.3).delay(0.3), value: showingAvatar)
                    HStack {
                        Button("Log out") {
                            logoutAction()
                        }
                        .appSystemButtonStyle(type: .destructive, width: (reader.size.width / 4) - 6, height: 50)
                        Button("Edit Profile") {
                            editProfileAction()
                        }
                        .appSystemButtonStyle(type: .normal, width: (reader.size.width / 4) - 6, height: 50)
                    }
                }
                .padding([.vertical, .trailing], 3)
                .frame(width: (reader.size.width / 2) - 6)
            }
            .backdrop(Asset.Colors.appLint.color)}
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                showingAvatar = true
            })
        }
    }
    
    private var infoList: some View {
        VStack {
            InfoCell(name: "firstname:", value: user.firstName)
            InfoCell(name: "lastname:", value: user.lastName)
            InfoCell(name: "email:", value: user.email)
            Spacer()
        }
        .padding(.top, 3)
    }
    
    private var userTappableImage: some View {
        Button {
            imageTappedAction()
        } label: {
            profileImage
        }
        .cornerRadius(UIValues.defaultCornerRadius)
        .overlay(
            RoundedRectangle(
                cornerRadius: UIValues.defaultCornerRadius)
                .stroke(Color(Asset.Colors.appBlue.color),
                        lineWidth: UIValues.defaultBorderWidth)
        )
    }
    
    private var profileImage: some View {
        Group {
            if userImage != nil {
                userImage!
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity)
                    .padding(3)
            } else {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: .infinity)
                    .padding(3)
            }
        }
       
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        
        UserInfoView(
            user: User(
                uid: "",
                email: "",
                displayName: "",
                refreshToken: "",
                profileImageURL: nil,
                firstName: nil,
                lastName: nil), userImage: .constant(Image(systemName: "Person"))) {
                    print("logoutAction")
                } editProfileAction: {
                    print("editProfileAction")
                } imageTappedAction: {
                    print("editProfileAction")
                }
        
    }
}
