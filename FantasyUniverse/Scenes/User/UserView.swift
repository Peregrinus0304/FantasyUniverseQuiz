//
//  AccountView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.07.2022.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var user: User
    @StateObject private var viewModel = UserViewModel()
    @State private var progressPlaceholder: Float = 0.1   // TODO: To be delated.
    @State private var animating = false
    @State private var inputImage: UIImage?
    
    @State private var showingImagePicker = false
    
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
                    .animateWithSpringOnAppear { animating.toggle() }
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
            .onAppear {
                viewModel.loadProfileImage(for: user)
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .alert(item: $viewModel.alert) { value in
                return value.alert
            }
        }
    }
    
    private var profileInfoView: some View {
        UserInfoView(
            user: user,
            userImage: $viewModel.selectedImage,
            logoutAction: { viewModel.signOut() },
            editProfileAction: {
                print("imageTappedAction")
                let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
                self.progressPlaceholder += randomValue },
            imageTappedAction: {
                showingImagePicker = true
            })
            .backdrop(Asset.Colors.appLint.color)
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        viewModel.selectedImage = Image(uiImage: inputImage)
        viewModel.updateProfileImage(image: inputImage)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
