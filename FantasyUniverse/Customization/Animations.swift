//
//  Animations.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 01.08.2022.
//

import SwiftUI

extension View {
    func animateWithSpring(
        using animation: Animation = .spring(
            response: 0.4,
            dampingFraction: 0.6,
            blendDuration: 1),
        _ action: @escaping () -> Void) -> some View {
            onAppear { withAnimation(animation) { action() } }
        }
}
