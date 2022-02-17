//
//  ProgressHeaderView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 06.02.2022.
//

import SwiftUI

struct ProgressHeaderView: View {
    
    let correctCount: String
    let wrongCount: String
    let progress: CGFloat
    
    var body: some View {
       
        VStack {
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Capsule()
                    .fill(Color.pink)
                    .frame(height: 6)
                Capsule()
                    .fill(Color.green)
                    .frame(width: progress, height: 6)
            }
            .padding()
            
            HStack {
                Label {
                    Text(correctCount)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } icon: {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                Label {
                    Text(wrongCount)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } icon: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }.padding()
        }
    }
    
}
