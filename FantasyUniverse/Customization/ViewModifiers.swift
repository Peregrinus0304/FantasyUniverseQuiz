//
//  ViewModifiers.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 29.07.2022.
//

import SwiftUI

struct DefaultLabelStyle: ViewModifier {
    
    let width: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.appLargeFont)
            .minimumScaleFactor(0.1)
            .padding(.horizontal, 2)
            .frame(width: width,
                   height: height,
                   alignment: .center)
            .background(Color(Asset.Colors.aquamarine.color))
            .foregroundColor(Color(Asset.Colors.navyBlue.color))
            .cornerRadius(UIValues.buttonCornerRadius)
            .overlay(
                RoundedRectangle(
                    cornerRadius: UIValues.buttonCornerRadius)
                    .stroke(Color(Asset.Colors.navyBlue.color),
                            lineWidth: 4)
            )
    }
}

struct DefaultLightLabelStyle: ViewModifier {
    
    let width: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.appLargeFont)
            .minimumScaleFactor(0.1)
            .padding(.horizontal, 2)
            .frame(width: width,
                   height: height,
                   alignment: .center)
            .background(Color(Asset.Colors.appLint.color))
            .foregroundColor(Color(Asset.Colors.appGreen.color))
            .cornerRadius(UIValues.buttonCornerRadius)
            .overlay(
                RoundedRectangle(
                    cornerRadius: UIValues.buttonCornerRadius)
                    .stroke(Color(Asset.Colors.appGreen.color),
                            lineWidth: 4)
            )
    }
}

struct DefaultDarkLabelStyle: ViewModifier {
    
    let width: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.appLargeFont)
            .minimumScaleFactor(0.1)
            .padding(.horizontal, 2)
            .frame(width: width,
                   height: height,
                   alignment: .center)
            .background(Color(Asset.Colors.appGreen.color))
            .foregroundColor(Color(Asset.Colors.aquamarine.color))
            .cornerRadius(UIValues.buttonCornerRadius)
            .overlay(
                RoundedRectangle(
                    cornerRadius: UIValues.buttonCornerRadius)
                    .stroke(Color(Asset.Colors.aquamarine.color),
                            lineWidth: 4)
            )
    }
}

extension View {
    func defaultLabelStyle(width: CGFloat, height: CGFloat) -> some View {
        modifier(DefaultLabelStyle(width: width, height: height))
    }
    
    func defaultDarkLabelStyle(width: CGFloat, height: CGFloat) -> some View {
        modifier(DefaultDarkLabelStyle(width: width, height: height))
    }
    
    func defaultLightLabelStyle(width: CGFloat, height: CGFloat) -> some View {
        modifier(DefaultLightLabelStyle(width: width, height: height))
    }
}
