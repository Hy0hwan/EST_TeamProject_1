//
//  CreateView.swift
//  Team7
//
//  Created by 김경언 on 5/13/25.
//
//  Created by 김경언 on 5/14/25.
//

import SwiftUI
import SwiftData

struct CreateView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var wordName: String = ""
    @State private var wordDefinition: String = ""
    @State private var tag: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            
                    }

                    Spacer()

                    Button {
                        let newWord = Word(wordName: wordName, wordDefinition: wordDefinition, tag: tag)
                        context.insert(newWord)
                        try? context.save()
                        dismiss()
                    } label: {
                        Text("저장")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                
                Text("단어 작성")
                    .font(.title2)
                    .bold()
                    .frame(height: 20)

                
                VStack(spacing: 20) {
                    TextField("단어 입력", text: $wordName)
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

                    TextEditor(text: $wordDefinition)
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
            }
        }
    }
}

#Preview {
    CreateView()
}

