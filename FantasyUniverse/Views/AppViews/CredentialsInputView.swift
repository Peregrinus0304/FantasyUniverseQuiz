//
//  CredentialsInputView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 14.05.2022.
//

import SwiftUI

struct CredentialsInputField: View {
    
    let labelText: String
    let textFieldPlaceholder: String
    @Binding var textFieldValue: String
    @State private var isHighlighted = false
    var valueModified: () -> Void
    
    var body: some View {
        VStack {
            titleHeader
                .frame(height: UIValues.defaultInfoLabelHeight)
                textField
        }
    }
    
    var textField: some View {
        TextField(
            textFieldPlaceholder,
            text: $textFieldValue,
            onEditingChanged: { edited in
                isHighlighted = edited
                valueModified()
            })
            .onChange(of: textFieldValue, perform: { _ in
                valueModified()
            })
            .defaultTextFieldStyle(isHighlighted: $isHighlighted)
            .padding([.horizontal, .bottom], UIValues.defaultPadding)
    }
    
    var titleHeader: some View {
        Text(labelText)
            .font(isHighlighted ? .appLargeFont : .appMediumFont)
            .foregroundColor(Color(isHighlighted ? Asset.Colors.navyBlue.color : Asset.Colors.appBlue.color))
    }
    
}
