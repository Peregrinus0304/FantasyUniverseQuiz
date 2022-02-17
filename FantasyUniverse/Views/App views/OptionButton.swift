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
    var color: Color
    
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
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(color)
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(10)
        }
    }
    
}
