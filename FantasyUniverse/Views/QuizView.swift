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
    private let firebaseAuthService = FirebaseAuthService()
    
    var body: some View {
        
        ZStack {
            animatedBackground
            if data.questionsData.isEmpty {
                ProgressView()
            } else {
                if answered == data.questionsData.count {
                 // Finish screen
                    scoreView
                } else {
                 // Game screen
                    VStack {
                        topProgress
                        questionView
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width - 10)
                }
            }
        }
        .onAppear {
            data.getQuestions(set: set)
        }
    }
    
    var animatedBackground: some View {
        LottieView(animationName: "day-background", loopMode: .loop, contentMode: .scaleAspectFit)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
    
    var scoreView: some View {
        ScoreView(correctScore: correct, wrongScore: wrong) {
            present.wrappedValue.dismiss()
        }
        .background(.thinMaterial)
    }
    
    var topProgress: some View {
        ProgressHeaderView(correctCount: correct == .zero ? "" : "\(correct)",
                           wrongCount: wrong == .zero ? "" : "\(wrong)",
                           progress: progress())
    }
    
    var questionView: some View {
        QuestionView(questions: $data.questionsData,
                     currentQuestion: data.questionsData[.zero],
                     correct: $correct,
                     wrong: $wrong,
                     answered: $answered)
            .padding()
    }
    
    private func progress() -> CGFloat {
        let fraction = CGFloat(answered) / CGFloat(data.questionsData.count)
        let width = UIScreen.main.bounds.width - 30
        return fraction * width
    }
}
