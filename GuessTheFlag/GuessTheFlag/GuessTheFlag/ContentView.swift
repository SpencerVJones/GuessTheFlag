//  ContentView.swift
//  GuessTheFlag
//  Created by Spencer Jones on 6/14/25

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
        
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 53/255, green: 200/255, blue: 255/255),
                    Color(red: 2/255, green: 25/255, blue: 50/255),
                    Color(red: 53/255, green: 200/255, blue: 255/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                VStack {
                    Text("Select the flag of")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .resizable()
                                .frame(width: 100, height: 65)
                                .clipShape(.rect(cornerRadius: 12))
                                .shadow(radius: 8)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 12))
                    }
                }
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
}

#Preview {
    ContentView()
}
