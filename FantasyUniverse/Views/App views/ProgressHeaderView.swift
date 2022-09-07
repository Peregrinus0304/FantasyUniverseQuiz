//
//  ProgressHeaderView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 06.02.2022.
//

import SwiftUI

struct ProgressHeaderView: View {
    
    @Binding var correctCount: Int
    @Binding var wrongCount: Int
    let progress: CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Capsule()
                    .fill(Color(Asset.Colors.aquamarine.color))
                    .frame(height: 20.0)
                Capsule()
                    .fill(Color(Asset.Colors.appBlue.color))
                    .frame(width: progress, height: 20.0)
                    .animation(.linear)
            }
            .padding()
            
            HStack {
                Label {
                    Text(correctCount == .zero ? "" : "\(correctCount)")
                        .font(.appLargeFont)
                        .foregroundColor(Color(Asset.Colors.appGreen.color))
                } icon: {
                    Image(systemName: "checkmark")
                        .font(.appLargeFont)
                        .foregroundColor(Color(Asset.Colors.appGreen.color))
                }
                Spacer()
                Label {
                    Text(wrongCount == .zero ? "" : "\(wrongCount)")
                        .font(.appLargeFont)
                        .foregroundColor(Color(Asset.Colors.appRed.color))
                } icon: {
                    Image(systemName: "xmark")
                        .font(.appLargeFont)
                        .foregroundColor(Color(Asset.Colors.appRed.color))
                }
            }
            .padding()
        }
    }
    
}
