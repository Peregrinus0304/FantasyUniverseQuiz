//
//  DashboardView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.12.2021.
//

import SwiftUI

struct DashboardView: View {
    
    @AppStorage("email") var username: String = "Anonymous"
    @State var show = false
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    @State var selectedSet = ""
    let sets = QuestionSet.allSets
    
    var body: some View {
        ZStack {
            animatedBackground
            VStack {
                usernameLabel
                instructionLabel
                Spacer()
                collectionView
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $show) {
            cleanUp()
        } content: {
            QuizView(correct: $correct, wrong: $wrong, answered: $answered, set: $selectedSet)
        }
    }
    
    var animatedBackground: some View {
        LottieView(animationName: "dashboard-background", loopMode: .loop, contentMode: .scaleAspectFit)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
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
                            .font(.title2)
                            .fontWeight(.heavy)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .cornerRadius(15)
                    .onTapGesture(perform: {
                        selectedSet = sets[index].collectionIdentifier
                        show.toggle()
                    })
                }
            })
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding()
        }
    }
    
    var usernameLabel: some View {
        Text("Welcome, \(username)!")
            .font(.system(size: 28))
            .fontWeight(.heavy)
    }
    
    var instructionLabel: some View {
        Text("What is your today`s quizz ?")
            .font(.system(size: 28))
    }
    
    private func cleanUp() {
        correct = 0
        wrong = 0
        answered = 0
    }
}
