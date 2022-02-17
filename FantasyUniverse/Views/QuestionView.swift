//
//  QuestionView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 01.02.2022.
//

import SwiftUI

struct QuestionView: View {
    
    @Binding var questions: [Question]
    @State var currentQuestion: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    @State var selected = ""
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Question
            QuestionLabelView(text: currentQuestion.question!)
                .lineLimit(4)
            Spacer()
            
            OptionButton(color: buttonColor(option: currentQuestion.optionA!),
                         text: currentQuestion.optionA!,
                         action: {
                selected = currentQuestion.optionA!
            })
                .disabled(selected.isEmpty ? false : true)
                .opacity(selected.isEmpty ? 1 : 0.7)
            
            OptionButton(color: buttonColor(option: currentQuestion.optionB!),
                         text: currentQuestion.optionB!,
                         action: {
                selected = currentQuestion.optionB!
            }).lineLimit(nil)
                .disabled(selected.isEmpty ? false : true)
                .opacity(selected.isEmpty ? 1 : 0.7)
            
            OptionButton(color: buttonColor(option: currentQuestion.optionC!),
                         text: currentQuestion.optionC!,
                         action: {
                selected = currentQuestion.optionC!
            }).lineLimit(nil)
                .disabled(selected.isEmpty ? false : true)
                .opacity(selected.isEmpty ? 1 : 0.7)
            
            OptionButton(color: buttonColor(option: currentQuestion.optionD!),
                         text: currentQuestion.optionD!,
                         action: {
                selected = currentQuestion.optionD!
            }).lineLimit(nil)
                .disabled(selected.isEmpty ? false : true)
                .opacity(selected.isEmpty ? 1 : 0.7)
            
            Spacer()
            
            Button("Next") {
                withAnimation {
                    currentQuestion.completed.toggle()
                    answered += 1
                }
                checkAnswer()
            }.buttonStyle(AppNextButton())
            .disabled(selected.isEmpty ? true : false)
            .opacity(selected.isEmpty ? 0.7 : 1)
            .padding(.bottom)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(25)
    }
    
    private func buttonColor(option: String) -> Color {
        
        if currentQuestion.isSubmitted {
            return Color.gray
        } else {
            if !selected.isEmpty {
                if option == currentQuestion.correct! {
                    return .green
                } else {
                    return .red
                }
            }
            
        }
        return Color.gray
    }
    
    private func checkAnswer() {
        if selected == currentQuestion.correct! {
            correct += 1
        } else {
            wrong += 1
        }
        currentQuestion.isSubmitted.toggle()
        currentQuestion = questions[answered - 1]
        selected = ""
    }

}
