//
//  AppTextFieldStyles.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.04.2022.
//

import SwiftUI

struct AppStandardTextFieldStyle: TextFieldStyle {
    // swiftlint:disable identifier_name
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .textFieldStyle(PlainTextFieldStyle())
            .multilineTextAlignment(.leading)
            .accentColor(.pink)
            .foregroundColor(.white)
            .font(.title.weight(.semibold))
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(Asset.Colors.appPurple.color), .blue]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
            .frame(height: 50)
            .cornerRadius(15)
    }
}
