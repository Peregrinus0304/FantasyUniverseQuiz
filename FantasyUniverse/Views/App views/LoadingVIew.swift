//
//  LoadingVIew.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 31.07.2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Loading...")
                .font(.appVeryLargeFont)
                .foregroundColor(Color(Asset.Colors.appGreen.color))
            LottieView(
                animationName: "loading-logo",
                loopMode: .loop,
                contentMode: .center)
                .frame(height: 200)
            Spacer()
        }
        .background(.thinMaterial)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
