//
//  WordFormView.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//
// // Create/Update 화면 (기본 입력 UI만 포함)

import SwiftUI
import SwiftData

struct WordFormView: View {
    @Environment(\.modelContext) private var context

    @State private var protocolword: String = ""
    @State private var tag: String = ""
    @State private var meaning: String = ""

    @State private var navigateToDetail = false
    @State private var savedWord: Word? = nil

    var existingWord: Word? = nil

    init(existingWord: Word? = nil) {
        self.existingWord = existingWord
        _protocolword = State(initialValue: existingWord?.wordName ?? "")
        _meaning = State(initialValue: existingWord?.wordDefinition ?? "")
        _tag = State(initialValue: existingWord?.tag ?? "")
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                HStack {
                    Button("취소") {
                    
                    }

                    Spacer()

                    Button("저장") {
                        if let existingWord {
                            existingWord.wordName = protocolword
                            existingWord.wordDefinition = meaning
                            existingWord.tag = tag
                            try? context.save()
                            savedWord = existingWord
                        } else {
                            let newWord = Word(
                                wordName: protocolword,
                                wordDefinition: meaning,
                                tag: tag
                            )
                            context.insert(newWord)
                            savedWord = newWord
                        }

                        navigateToDetail = true
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                Text(existingWord == nil ? "단어 작성" : "단어 수정")
                    .font(.title2)
                    .bold()
                    .frame(height: 20)

                VStack(spacing: 20) {
                    TextField("Protocol", text: $protocolword)
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )

                    TextField("태그", text: $tag)
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )

                    TextEditor(text: $meaning)
                        .frame(height: 200)
                        .padding(.top, 8)
                        .padding(.horizontal, 4)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                Spacer()

                NavigationLink(
                    isActive: $navigateToDetail,
                    destination: {
                        Group {
                            if let word = savedWord {
                                WordFormView2(word: word)
                            } else {
                                EmptyView()
                            }
                        }
                    },
                    label: {
                        EmptyView()
                    }
                )
                .hidden()

            }
        }
    }
}
#Preview {
    WordFormView()
}
