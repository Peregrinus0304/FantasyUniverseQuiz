//
//  Font+Extensions.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 29.07.2022.
//

import SwiftUI

extension Font {
    static let appVeryLargeFont = Font.custom("Verdana-Bold", size: 32, relativeTo: .largeTitle)
    static let appLargeFont = Font.custom("Verdana-Bold", size: 28, relativeTo: .largeTitle)
    static let appMediumFont = Font.custom("Verdana", size: 22, relativeTo: .title)
    static let appMediumBoldFont = Font.custom("Verdana-Bold", size: 22, relativeTo: .title)
    static let appSmallFont = Font.custom("Verdana", size: 18, relativeTo: .body)
}
