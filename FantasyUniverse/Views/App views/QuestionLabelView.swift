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
       
            Text(text ?? "")
                .font(.system(size: 30))
                .minimumScaleFactor(0.4)
                .lineLimit(4)
                .layoutPriority(4)
    //            .allowsTightening(false)
    //            .fontWeight(.heavy)
    //            .foregroundColor(.black)
    //            .fixedSize(horizontal: false, vertical: false)
                .padding(.top, 25)
    }
}
