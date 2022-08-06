//
//  DashboardView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.12.2021.
//

import SwiftUI

struct DashboardView: View {
    
    @State var showSelectedQuiz = false
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    @State var selectedSet: QuestionSet = .none
    let sets = QuestionSet.allSets
    
    var body: some View {
        AnimatedBackground(animationName: "dashboard-background") {
                VStack {
                    instructionLabel
                    Spacer()
                    collectionView
                    Spacer()
                }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showSelectedQuiz) {
            cleanUp()
        } content: {
            QuizView(correct: $correct, wrong: $wrong, answered: $answered, set: $selectedSet)
        }
    }
    
    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns:
                        Array(repeating:
                                GridItem(.flexible(),
                                         spacing: 20),
                              count: 2),
                      spacing: 20,
                      content: {
                ForEach(sets.indices, id: \.self) { index in
                    VStack(spacing: 20) {
                        LottieView(animationName: sets[index].logoAnimationName,
                                   loopMode: .loop,
                                   contentMode: .scaleAspectFit)
                            .frame(width: 150, height: 150)
                        
                        Text(sets[index].collectionIdentifier)
                            .font(.appMediumFont)
                            .foregroundColor(Color(Asset.Colors.navyBlue.color))
                            
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .cornerRadius(15)
                    .onTapGesture(perform: {
                        selectedSet = sets[index]
                        showSelectedQuiz.toggle()
                    })
                }
            })
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding()
        }
    }
    
    var instructionLabel: some View {
        Text("Available quizzes")
            .font(.appLargeFont)
            .foregroundColor(Color(Asset.Colors.navyBlue.color))
    }
    
    private func cleanUp() {
        correct = 0
        wrong = 0
        answered = 0
    }
}
