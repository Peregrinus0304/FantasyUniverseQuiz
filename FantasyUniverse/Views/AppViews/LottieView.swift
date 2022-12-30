//  LottieView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 24.12.2021.

import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewRepresentable {
    let animationName: String
    let loopMode: LottieLoopMode
    let contentMode: UIView.ContentMode 
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        uiView.subviews.forEach({ $0.removeFromSuperview() })
        let animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: uiView.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
            animationView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            animationView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor)
        ])
        
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
    }
}
