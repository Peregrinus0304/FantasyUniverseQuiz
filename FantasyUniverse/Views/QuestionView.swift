//
//  QuestionView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 01.02.2022.
//

import SwiftUI

struct QuestionView: View {
    
    @Binding var questions: [QuestionViewData]
    @State var currentQuestion: QuestionViewData
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    @State var selected = ""
    @State private var animatedOffsetX: CGFloat = .zero
    
    var body: some View {
        
        VStack(spacing: 10) {
            // Question
            Text(currentQuestion.question)
                .questionLabelStyle()
            // Options
            optionButtons
            Spacer()
            nextButton
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(25)
        .offset(x: animatedOffsetX)
        .animation(.spring(
            response: 0.4,
            dampingFraction: 0.6,
            blendDuration: 1), value: animatedOffsetX)
    }
    
    var optionButtons: some View {
        ForEach(currentQuestion.answers.indices, id: \.self) { index in
            OptionButton(color: buttonColor(option: currentQuestion.answers[index].answer),
                         text: currentQuestion.answers[index].answer,
                         action: {
                selected = currentQuestion.answers[index].answer
            })
                .disabled(!selected.isEmpty)
                .opacity(selected.isEmpty ? 1 : 0.7)
        }
    }
    
    var nextButton: some View {
        Button("Next") {
            animateNextQuestion {
                currentQuestion.completed.toggle()
                answered += 1
                checkAnswer()
            }
        }.appSystemButtonStyle(type: .normal)
            .disabled(selected.isEmpty)
            .opacity(selected.isEmpty ? 0.7 : 1)
            .padding(.bottom)
    }
    
    private func buttonColor(option: String) -> Color {
        let unselectedColor = Color(Asset.Colors.aquamarine.color)
        let correctColor = Color(Asset.Colors.appGreen.color)
        let incorrectColor = Color(Asset.Colors.appRed.color)
        let correctAnswer = currentQuestion.answers.filter { $0.correct }[.zero].answer
        return selected.isEmpty ? unselectedColor : (option == correctAnswer ? correctColor : (option == selected ? incorrectColor : unselectedColor))
    }
    
    private func animateNextQuestion(completion: @escaping () -> Void) {
        animatedOffsetX = 400
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            completion()
            animatedOffsetX = .zero
        }
    }
    
    private func checkAnswer() {
        let correctAnswer = currentQuestion.answers.filter { $0.correct }[.zero].answer
        if selected == correctAnswer {
            correct += 1
        } else {
            wrong += 1
        }
        currentQuestion.isSubmitted.toggle()
        if questions.count != answered {
            currentQuestion = questions[answered]
        }
        selected = ""
    }
    
}
