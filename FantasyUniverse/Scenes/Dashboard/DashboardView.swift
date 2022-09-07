//
//  DashboardView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.12.2021.
//

import SwiftUI

struct DashboardView: View {
    
    let sets = QuestionSet.allSets
    @State var showSelectedQuiz = false
    @State var showListItems = false
    @State var animationDelay = 0.2
    @State var selectedSet: QuestionSet = .none
    var body: some View {
        NavigationView {
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
                QuizView(set: $selectedSet)
            }
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
                    .opacity(showListItems ? 1 : 0)
                    .animation(
                        Animation.easeOut(duration: 0.3)
                            .delay(animationDelay * Double(index)),
                        value: showListItems)
                    .onTapGesture(perform: {
                        selectedSet = sets[index]
                        showSelectedQuiz.toggle()
                    })
                }
            })
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                showListItems = true
            })
        }
    }
    
    private var instructionLabel: some View {
        Text("Available quizzes")
            .font(.appLargeFont)
            .foregroundColor(Color(Asset.Colors.navyBlue.color))
    }
}
