//
//  QuestionView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 25.12.2021.
//

import SwiftUI

struct QuizView: View {
    
    @Binding var set: QuestionSet
    @StateObject var viewModel = QuizViewModel()
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        AnimatedBackground(animationName: "day-background") {
            if viewModel.questionsData.isEmpty {
                LoadingView()
            } else {
                if viewModel.answered == viewModel.questionsData.count {
                    // Finish screen
                    scoreView
                } else {
                    // Game screen
                    VStack(alignment: .center) {
                        topProgress
                        questionView
                    }
                    .padding(.horizontal, 5)
                }
            }
            
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getQuestions(set: set)
        }
        .onDisappear {
            cleanUp()
        }
    }
    
    var animatedBackground: some View {
        LottieView(animationName: "day-background", loopMode: .loop, contentMode: .scaleAspectFit)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
    
    var scoreView: some View {
        ScoreView(correctScore: viewModel.correct, wrongScore: viewModel.wrong) {
            present.wrappedValue.dismiss()
        }
        .background(.thinMaterial)
    }
    
    var topProgress: some View {
        ProgressHeaderView(correctCount: $viewModel.correct,
                           wrongCount: $viewModel.wrong ,
                           progress: progress())
    }
    
    var questionView: some View {
        QuestionView(questions: $viewModel.questionsData,
                     currentQuestion: viewModel.questionsData[.zero],
                     correct: $viewModel.correct,
                     wrong: $viewModel.wrong,
                     answered: $viewModel.answered)
            .padding()
    }
    
    private func progress() -> CGFloat {
        let fraction = CGFloat(viewModel.answered) / CGFloat(viewModel.questionsData.count)
        let width = UIScreen.main.bounds.width - 30
        return fraction * width
    }
    
    private func cleanUp() {
        viewModel.correct = 0
        viewModel.wrong = 0
        viewModel.answered = 0
    }
}
