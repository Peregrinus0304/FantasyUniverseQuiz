//
//  ErrorView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.07.2022.
//

import SwiftUI

struct ErrorView: View {
    
    enum ErrorViewType {
        case error, warning
        var animationName: String {
            switch self {
            case .error: return "error-logo"
            case .warning: return "warning-logo"
            }
        }
        var color: Color {
            switch self {
            case .error: return Color(Asset.Colors.appRed.color)
            case .warning: return  Color(Asset.Colors.appYellow.color)
            }
        }
        
    }
    
    var type: ErrorViewType
    @Binding var text: String
    
    var body: some View {
        if !text.isEmpty {
            HStack {
                LottieView(
                    animationName: type.animationName,
                    loopMode: .playOnce,
                    contentMode: .scaleAspectFit)
                    .frame(width: UIValues.defaultMinorElementHeight)
                
                Text(text)
                    .font(.appMediumFont)
                    .foregroundColor(type.color)
                    .minimumScaleFactor(0.6)
                    .lineLimit(nil)
                    .allowsTightening(true)
            }
            .frame(height: UIValues.defaultMinorElementHeight)
            .background(.regularMaterial)
            .cornerRadius(UIValues.defaultCornerRadius)
        } else {
            Spacer()
                .frame(height: UIValues.defaultMinorElementHeight)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(type: .error, text: .constant("Error"))
    }
}
