//
//  WordFormView.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//

import SwiftUI
import SwiftData
// // Create/Update 화면 (기본 입력 UI만 포함)

struct WordFormView: View {
    @Environment(\.modelContext) private var context
    @State private var protocolword: String = ""
    @State private var tag: String = ""
    @State private var meaning: String = ""
    
    @State private var navigateToDetail = true
    @State private var savedWord: Word? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                HStack {
                    Button("취소") {
                    }
                    
                    Spacer()
                    
                    Button("저장") {
                        let newWord = Word(
                            wordName: protocolword,
                            wordDefinition: meaning,
                            tag: nil
                        )
                        context.insert(newWord)
                        savedWord = newWord
                        navigateToDetail = true
                        print("저장됨: \(newWord.wordName) / \(newWord.wordDefinition)")
                        
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                
                Text("단어 작성")
                    .font(.title2)
                    .bold()
                    .frame(height: 20)
                
                VStack(spacing:20) {
                    TextField("Protocol", text: $protocolword)
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    
                    
                    TextField("태그", text: $tag)
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    
                    
                    TextEditor(text: $meaning)
                        .frame(height: 200)
                        .padding(.top, 8)
                        .padding(.horizontal, 4)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: destinationView, isActive: $navigateToDetail) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
    var destinationView: some View {
        Group {
            if let word = savedWord {
                WordFormView2(word: word)
            } else {
                EmptyView()
            }
        }
    }
    
    
    
    // Detail View
    struct WordFormView2: View {
        var word: Word
        
        var body: some View {
            VStack(spacing: 15) {
                HStack {
                    Button("삭제") {}
                    Spacer()
                    Button("수정") {}
                }
                .padding(.horizontal)
                .padding(.top)
                
                Text("단어 상세")
                    .font(.title2)
                    .bold()
                    .frame(height: 20)
                
                HStack(spacing: 4) {
                    Text(word.wordName)
                        .font(.body)
                    Spacer()
                    if let tag = word.tag?.name {
                        Text(tag)
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 15)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                HStack {
                    Text(formattedDate(word.createdAt))
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 4) {
                    Text(word.wordDefinition)
                        .font(.body)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 15)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        
        func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy. MM. dd"
            return formatter.string(from: date)
        }
    }
    
}


#Preview {
    WordFormView()
}
