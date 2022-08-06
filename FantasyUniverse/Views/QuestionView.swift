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
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Question
            Text(currentQuestion.question)
                .questionLabelStyle()
//            QuestionLabelView(text: currentQuestion.question)
            // Options
            optionButtons
            Spacer()
            nextButton
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(25)
    }
    
    var optionButtons: some View {
        ForEach(currentQuestion.answers.indices, id: \.self) { index in
            OptionButton(color: buttonColor(option: currentQuestion.answers[index].answer),
                         text: currentQuestion.answers[index].answer,
                         action: {
                selected = currentQuestion.answers[index].answer
            }).lineLimit(nil)
                .disabled(!selected.isEmpty)
                .opacity(selected.isEmpty ? 1 : 0.7)
        }
    }
    
    var nextButton: some View {
        Button("Next") {
            withAnimation {
                currentQuestion.completed.toggle()
                answered += 1
            }
            checkAnswer()
        }.buttonStyle(AppNextButton())
            .disabled(selected.isEmpty)
            .opacity(selected.isEmpty ? 0.7 : 1)
            .padding(.bottom)
    }
    
    private func buttonColor(option: String) -> Color {
        let correctAnswer = currentQuestion.answers.filter { $0.correct }[0].answer
        return selected.isEmpty ? .gray : (option == correctAnswer ? .green : (option == selected ? .red : .gray))
    }
    
    private func checkAnswer() {
        let correctAnswer = currentQuestion.answers.filter { $0.correct }[0].answer
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
