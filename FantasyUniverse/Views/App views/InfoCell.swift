//
//  InfoCell.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 31.07.2022.
//

import SwiftUI

struct InfoCell: View {
    
    var name: String
    var value: String?

    var body: some View {
        HStack {
            Text(name)
                .font(.appSmallFont)
                .foregroundColor(Color(Asset.Colors.appBlue.color))
                .minimumScaleFactor(0.4)
                .lineLimit(1)
                .allowsTightening(true)
                .padding(.leading, 2)

            Text(value ?? "none")
                .font(.appLargeFont)
                .foregroundColor(Color(Asset.Colors.appGreen.color))
                .minimumScaleFactor(0.6)
                .lineLimit(1)
                .allowsTightening(true)
                .padding(.trailing, 2)
        }
        .frame(height: UIValues.defaultMinorElementHeight, alignment: .leading)
        .frame(maxWidth: .infinity)

        .background(.regularMaterial)
        .cornerRadius(UIValues.defaultCornerRadius)
        .overlay(
            RoundedRectangle(
                cornerRadius: UIValues.defaultCornerRadius)
                .stroke(Color(Asset.Colors.appBlue.color),
                        lineWidth: UIValues.minimalBorderWidth)
        )
    }
}

struct InfoCell_Previews: PreviewProvider {
    static var previews: some View {
        InfoCell(name: "", value: "")
    }
}
