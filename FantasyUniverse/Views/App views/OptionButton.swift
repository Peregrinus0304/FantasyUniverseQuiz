//
//  OptionButton.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 04.02.2022.
//

import SwiftUI

struct OptionButton: View {

    let action: () -> Void
    let text: String
    let color: Color
    
    init(color: Color, text: String, action: @escaping () -> Void) {
        self.color = color
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.appMediumFont)
                .foregroundColor(Color(Asset.Colors.appLint.color))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .background(color)
                .minimumScaleFactor(0.4)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .allowsTightening(true)
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(UIValues.defaultCornerRadius)
        }
    }
    
}
