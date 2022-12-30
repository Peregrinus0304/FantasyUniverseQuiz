//
//  Animations.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 01.08.2022.
//

import SwiftUI

// MARK: - Animations

extension View {
    func animateWithSpringOnAppear(
        using animation: Animation = .spring(
            response: 0.4,
            dampingFraction: 0.6,
            blendDuration: 1),
        _ action: @escaping () -> Void) -> some View {
            onAppear { withAnimation(animation) { action() } }
        }
}

// MARK: - Other

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
