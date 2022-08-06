//
//  View+Extensions.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 30.07.2022.
//

import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
