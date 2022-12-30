//
//  ViewModifiers.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 29.07.2022.
//

import SwiftUI
import Combine
import UIKit

struct CustomBackground: ViewModifier {
    
    let color: UIColor
    
    func body(content: Content) -> some View {
        content
            .background(Color(color))
    }
}

struct AppLabelStyle: ViewModifier {
    
    enum Style {
        case normal, light, dark
    }

    let style: Style
    let width: CGFloat
    let height: CGFloat
    
    private var backgroundColor: Color {
        switch style {
        case .normal: return Color(Asset.Colors.aquamarine.color)
        case .light: return Color(Asset.Colors.appLint.color)
        case .dark: return Color(Asset.Colors.appGreen.color)
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .normal: return Color(Asset.Colors.navyBlue.color)
        case .light: return Color(Asset.Colors.appGreen.color)
        case .dark: return Color(Asset.Colors.appLint.color)
        }
    }
    
    private var strokeColor: Color {
        switch style {
        case .normal: return Color(Asset.Colors.navyBlue.color)
        case .light: return Color(Asset.Colors.appGreen.color)
        case .dark: return Color(Asset.Colors.aquamarine.color)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.appLargeFont)
            .minimumScaleFactor(0.1)
            .padding(.horizontal, 2)
            .frame(width: width,
                   height: height,
                   alignment: .center)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(UIValues.defaultCornerRadius)
            .overlay(
                RoundedRectangle(
                    cornerRadius: UIValues.defaultCornerRadius)
                .stroke(strokeColor,
                        lineWidth: UIValues.defaultBorderWidth)
            )
    }
}

/// KeyboardAwareModifier taken from: https://gist.github.com/perlguy99/4f74c3ee7073921123c0df151ae7fe51

struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    
    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                .map { $0.cgRectValue.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        ).eraseToAnyPublisher()
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) {
                self.keyboardHeight = $0
            }
    }
}

struct AppStandardTextFieldStyle: TextFieldStyle {
    
    @Binding var isHighlighted: Bool
    
    // swiftlint:disable identifier_name
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .textFieldStyle(PlainTextFieldStyle())
            .multilineTextAlignment(.leading)
            .accentColor(Color(Asset.Colors.navyBlue.color))
            .foregroundColor(Color(Asset.Colors.navyBlue.color))
            .font(.appMediumFont)
            .frame(height: UIValues.defaultMinorElementHeight)
            .padding(.horizontal, UIValues.defaultPadding)
            .background(
                LinearGradient(gradient:
                                Gradient(colors:
                                            [Color(Asset.Colors.aquamarine.color),
                                             Color(Asset.Colors.appLint.color)]),
                               startPoint: .top,
                               endPoint: .bottom))
            .cornerRadius(UIValues.defaultCornerRadius)
            .overlay(
                RoundedRectangle(
                    cornerRadius: UIValues.defaultCornerRadius)
                .stroke(Color(isHighlighted ? Asset.Colors.navyBlue.color : Asset.Colors.appBlue.color),
                        lineWidth: UIValues.defaultBorderWidth)
            )
            .edgesIgnoringSafeArea(.all)
    }
}

struct AppSystemButtonStyle: ButtonStyle {
    
    enum ButtonType {
        case normal, destructive
    }
    
    let type: ButtonType
    var width: CGFloat?
    var height: CGFloat?
    
    private var color: Color {
        switch type {
        case .normal: return Color(Asset.Colors.navyBlue.color)
        case .destructive: return Color(Asset.Colors.appRed.color)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.appMediumFont)
            .minimumScaleFactor(0.1)
            .padding(.horizontal, 2)
            .frame(width: width,
                   height: height)
            .multilineTextAlignment(.center)
            .background(color)
            .foregroundColor(Color(Asset.Colors.appLint.color))
            .cornerRadius(UIValues.defaultCornerRadius)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct QuestionLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appLargeFont)
            .foregroundColor(Color(Asset.Colors.navyBlue.color))
            .minimumScaleFactor(0.6)
            .lineLimit(5)
            .multilineTextAlignment(.center)
            .allowsTightening(true)
            .fixedSize(horizontal: false, vertical: true)
            .padding([.top, .bottom], 20)
    }
}

struct AppNavigationViewModifier: ViewModifier {
    
    let titleFont = UIFont(name: "Verdana-Bold", size: 28) ?? .systemFont(ofSize: 28)
    
    init() {
        let attributes: [NSAttributedString.Key: Any]? = [
            .font: titleFont,
            .foregroundColor: Asset.Colors.navyBlue.color,
            .backgroundColor: UIColor.clear]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        UINavigationBar.appearance().tintColor = Asset.Colors.navyBlue.color
        UINavigationBar.appearance().barTintColor = Asset.Colors.appLint.color
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    
    func backdrop(_ color: UIColor) -> some View {
        modifier(CustomBackground(color: color))
    }
    
    func appLabelStyle(style: AppLabelStyle.Style, width: CGFloat, height: CGFloat) -> some View {
        modifier(AppLabelStyle(style: style, width: width, height: height))
    }
    
    func keyboardAwarePadding() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    }
    
    func defaultTextFieldStyle(isHighlighted: Binding<Bool>) -> some View {
        self.textFieldStyle(AppStandardTextFieldStyle(isHighlighted: isHighlighted))
    }
    
    func appSystemButtonStyle(type: AppSystemButtonStyle.ButtonType, width: CGFloat? = UIValues.defaultButtonWidth, height: CGFloat? = UIValues.defaultMinorElementHeight) -> some View {
        self.buttonStyle(AppSystemButtonStyle(type: type, width: width, height: height))
    }
    
    func questionLabelStyle() -> some View {
        modifier(QuestionLabelStyle())
    }
    
    func appNavigationViewStyle() -> some View {
        modifier(AppNavigationViewModifier())
    }
    
}
