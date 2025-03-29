//
//  ContentView.swift
//  MathWhiz
//
//  Created by Kamol Madaminov on 29/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tableRange = 2
    @State private var secondNumber = 2
    @State private var questionsAmount = [5, 10, 15, 20]
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var selectedQuestionAmount = 5
    @State private var isStarted = false
    @State private var inputtedAnswer = 0
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            List {
                if !isStarted {
                    Section("Settings") {
                        Stepper("Choose a range: \(tableRange)", value: $tableRange, in: 2...12)
                        Picker("Questions amount", selection: $selectedQuestionAmount) {
                            ForEach(questionsAmount, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    Button("Start") {
                        isStarted = true
                    }
                } else if isStarted {
                    solvation()
                }
            }
            
            .navigationTitle("MathWhiz")
        }
    }
    
    
    func generateQuestion() -> Int {
                return Int.random(in: 2...12)
    }
    
    func showScore() -> some View {
        Section ("Result"){
            Text("Your score: \(score)/\(selectedQuestionAmount)")
                .font(.headline)
            Button("Main menu") {
                isStarted = false
                score = 0
                currentQuestionIndex = 0
            }
        }
    }
    
    @ViewBuilder func solvation() -> some View {
        if selectedQuestionAmount > currentQuestionIndex {
            Section("Question \(currentQuestionIndex + 1)") {
                Text("Input the result of \(tableRange) x \(secondNumber)")
                TextField("Input", value: $inputtedAnswer, format: .number)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Next") {
                                if inputtedAnswer == secondNumber * tableRange {
                                    score += 1
                                }
                                nextQuestion()
                            }
                            Button("Done") {
                                isTextFieldFocused = false
                            }
                        }
                    }
            }
        } else {
            showScore()
        }
    }
    
    func nextQuestion() {
        secondNumber = generateQuestion() // No table: parameter
        currentQuestionIndex += 1
        inputtedAnswer = 0
    }



}

#Preview {
    ContentView()
}
