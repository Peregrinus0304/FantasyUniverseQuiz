//
//  QuestionView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.12.2021.
//

import SwiftUI

struct QuizView: View {
    
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    @Binding var set: String
    @StateObject var data = QuestionViewModel()
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        ZStack {
            LottieView(animationName: "day-background", loopMode: .loop, contentMode: .scaleAspectFit)
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            if data.questionsData.isEmpty {
                ProgressView()
            } else {
                if answered == data.questionsData.count {
                    
                    // Finish screen
                    ScoreView(correctScore: correct, wrongScore: wrong) {
                        present.wrappedValue.dismiss()
                    }
//                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(.thinMaterial)
                   
                } else {
                    
                    // Game screen
                    VStack {
                        
                        // Top Progress
                        ProgressHeaderView(correctCount: correct == .zero ? "" : "\(correct)", wrongCount: wrong == .zero ? "" : "\(wrong)", progress: progress())
                        
                        // Question view
                        QuestionView(questions: $data.questionsData, currentQuestion: data.questionsData[.zero], correct: $correct, wrong: $wrong, answered: $answered)
                            .padding()
                        
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width - 10)
                }
            }
        }
        .onAppear {
            data.getQuestions(set: set)
            
        }
        
    }
    
    private func progress() -> CGFloat {
        
        let fraction = CGFloat(answered) / CGFloat(data.questionsData.count)
        let width = UIScreen.main.bounds.width - 30
        
        return fraction * width
    }
}
