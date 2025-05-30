//
//  WordFormView.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//
// // Create/Update 화면 (기본 입력 UI만 포함)

import SwiftUI
import SwiftData

struct UpdateView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Binding var isUpdatePresent: Bool
    
    @State private var protocolword: String = ""
    @State var tag: String = ""
    @State private var isShowingTagSheet = false
    
    
    @State private var meaning: String = ""
    
    var existingWord: Word?
    
    
    init(existingWord: Word? = nil, isUpdatePresent: Binding<Bool>) {
        self.existingWord = existingWord
        self._isUpdatePresent = isUpdatePresent
        _protocolword = State(initialValue: existingWord?.wordName ?? "")
        _meaning = State(initialValue: existingWord?.wordDefinition ?? "")
        _tag = State(initialValue: existingWord?.tag ?? "")
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                HStack {
                    Button("취소") {
                        isUpdatePresent = false
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Button("저장") {
                        if let word = existingWord {
                            word.wordName = protocolword
                            word.wordDefinition = meaning
                            word.tag = tag
                            try? context.save()
                        }
                        
                        isUpdatePresent = false
                        dismiss()
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                Text("단어 수정")
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 20) {
                    TextField("단어", text: $protocolword)
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    
                    Button {
                        isShowingTagSheet = true
                    } label: {
                        HStack {
                            Text(tag.isEmpty ? "태그 선택" : tag)
                                .foregroundColor(tag.isEmpty ? .gray : .black)
                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        // 선택이 되면 .시트로 문법view 띄우고 여기 문법에 value <-> tag
                    }
                    
                    TextEditor(text: $meaning)
                        .padding(8)
                        .frame(height: 200)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .sheet(isPresented: $isShowingTagSheet) {
                    TagListSheetView(isTagSheetOpen: $isShowingTagSheet, selectedTagName: $tag)
                }
    }
}
#Preview {
    UpdateView(isUpdatePresent: Binding.constant(false))
}


