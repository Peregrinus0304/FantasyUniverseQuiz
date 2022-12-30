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
        GeometryReader { reader in
            VStack(alignment: .center, spacing: 25) {
                LottieView(animationName: winScore() ? "smile-face" : "sad-face",
                           loopMode: .playOnce,
                           contentMode: .scaleAspectFit)
                    .padding(.horizontal, 1)
                
                Text(winScore() ? "Well done" : "You can do better")
                    .font(.appVeryLargeFont)
                    .foregroundColor(Color(Asset.Colors.navyBlue.color))
                
                HStack(spacing: 15) {
                    Image(systemName: "checkmark")
                        .font(.appLargeFont)
                        .foregroundColor(Color(Asset.Colors.appGreen.color))
                    
                    Text("\(correctScore)")
                        .font(.appMediumFont)
                        .foregroundColor(Color(Asset.Colors.appGreen.color))
                    
                    Image(systemName: "xmark")
                        .font(.appLargeFont)
                        .foregroundColor(Color(Asset.Colors.appRed.color))
                        .padding(.leading)
                    
                    Text("\(wrongScore)")
                        .font(.appMediumFont)
                        .foregroundColor(Color(Asset.Colors.appRed.color))
                }
                
                Button("Go to home") {
                    action()
                }
                .appSystemButtonStyle(type: .normal, width: reader.size.width / 2,
                                      height: UIValues.defaultMinorElementHeight)
            }
            
        }
        
    }
    
    func winScore() -> Bool {
        let mutatableSelf = self
        return mutatableSelf.correctScore - mutatableSelf.wrongScore >= 0 ? true : false
    }
    
    private func setTitle(correct: Int, wrong: Int) -> LottieView {
        let winScore = correct - wrong >= 0 ? true : false
        return LottieView(animationName: winScore ? "smile-face" : "sad-face",
                          loopMode: .loop,
                          contentMode: .scaleAspectFit)
    }
    
}
