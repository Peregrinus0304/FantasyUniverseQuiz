//
//  DashboardView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 19.12.2021.
//

import SwiftUI

struct DashboardView: View {
    
    @State var show = false
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    @State var selectedSet = ""
    var sets = QuestionSet.allSets
    
    private func cleanUp() {
       correct = 0
       wrong = 0
       answered = 0
    }
    
    var body: some View {
        ZStack {
            LottieView(name: "dashboard-background", loopMode: .loop)
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Text("The grid of quizes").font(.system(size: 28)).fontWeight(.heavy)
                
                Text("What is your today`s quizz ?").font(.system(size: 28))
                Spacer()
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20, content: {
                        
                        ForEach(sets.indices, id: \.self) { index in
                            VStack(spacing: 20) {
                                LottieView(name: sets[index].logoAnimationName, loopMode: .loop)
                                    .frame(width: 150, height: 150)
                                    .aspectRatio(contentMode: .fit)
                                   
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
                Spacer()
           }
        }
        .fullScreenCover(isPresented: $show) {
            cleanUp()
        } content: {
            QuizView(correct: $correct, wrong: $wrong, answered: $answered, set: $selectedSet)
        }
   }
}
                              
// struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//      }
//   }
