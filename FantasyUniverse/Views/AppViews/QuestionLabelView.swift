//
//  QuestionLabelView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 04.02.2022.
//

import SwiftUI

struct QuestionLabelView: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
            Text(text)
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .minimumScaleFactor(0.6)
                .lineLimit(nil)
                .allowsTightening(true)
                .padding([.top, .bottom], 25)
    }
}
