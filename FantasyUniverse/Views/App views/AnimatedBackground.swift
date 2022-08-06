//
//  AnimatedBackground.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.07.2022.
//
import SwiftUI
import Lottie

struct AnimatedBackground<Content: View>: View {
    let content: Content
    let animation: LottieView

    init(animationName: String, mode: LottieLoopMode = .loop, @ViewBuilder content: () -> Content) {
        self.content = content()
        animation = LottieView(animationName: animationName,
                   loopMode: mode,
                   contentMode: .scaleAspectFill)
    }

    var body: some View {
        ZStack {
            animation
                .ignoresSafeArea()
            content
                
        }
    }
}
