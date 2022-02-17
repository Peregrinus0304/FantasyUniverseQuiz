//
//  ScoreView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 06.02.2022.
//

import SwiftUI

struct ScoreView: View {
 
    let correctScore: Int
    let wrongScore: Int
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            LottieView(name: winScore() ? "smile-face" : "sad-face", loopMode: .playOnce)
                .padding()
            
            Text(winScore() ? "Well done" : "You can do better")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
            
            HStack(spacing: 15) {
                
                Image(systemName: "checkmark")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                
                Text("\(correctScore)")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Image(systemName: "xmark")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding(.leading)
                
                Text("\(wrongScore)")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            
            Button("Go to home") {
                action()
            }
            .buttonStyle(AppSystemButton())
            
        }
    }
    
    func winScore() -> Bool {
        let mutatableSelf = self
        return mutatableSelf.correctScore - mutatableSelf.wrongScore >= 0 ? true : false
    }
    
    private func setTitle(correct: Int, wrong: Int) -> LottieView {
        let winScore = correct - wrong >= 0 ? true : false
        return LottieView(name: winScore ? "smile-face" : "sad-face", loopMode: .loop)
    }
    
}
