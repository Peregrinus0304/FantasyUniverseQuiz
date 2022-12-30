//
//  CircularProgressView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 01.08.2022.
//

import SwiftUI

struct CircularProgressView: View {
    @Binding var progress: Float
    @State private var scale: CGFloat = 0
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color(Asset.Colors.aquamarine.color))

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(Asset.Colors.appBlue.color))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.spring(), value: progress)
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.appLargeFont)
                .foregroundColor(Color(Asset.Colors.appBlue.color))
        }
        .padding()
        .background(.thinMaterial)
        .frame(width: width + 30, height: height + 30)
        .cornerRadius(UIValues.defaultCornerRadius)
        .scaleEffect(scale)
        .animateWithSpringOnAppear { scale = 1 }
        .onDisappear { scale = .zero }
    }
}
