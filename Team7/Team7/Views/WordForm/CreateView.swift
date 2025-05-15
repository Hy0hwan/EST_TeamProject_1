//
//  WordFormView2.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//
import SwiftUI
import SwiftData

struct CreateView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var wordName: String = ""
    @State private var wordDefinition: String = ""
    @State var tag: String = ""
    @State private var isShowingTagSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                    .navigationBarBackButtonHidden(true)
                    
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
                    
                    ZStack(alignment: .leading) {
                        if wordName.isEmpty {
                            Text("단어 입력")
                                .foregroundColor(.gray)
                                .foregroundColor(Color("TextColor"))
                                .padding(.leading, 12)
                        }
                        TextField("", text: $wordName)
                            .foregroundColor(Color("TextColor"))
                            .padding(.horizontal, 12)
                    }
                    .frame(height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("DarkModeBorder"), lineWidth: 1))
                    
                    Button {
                        isShowingTagSheet = true
                    } label: {
                        HStack {
                            Text(tag.isEmpty ? "태그 선택" : tag)
                                .foregroundColor(tag.isEmpty ? .gray : Color("TextColor"))
                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("DarkModeBorder"), lineWidth: 1))
                    }
                    
                    ZStack(alignment: .topLeading) {
                        if wordDefinition.isEmpty {
                            Text("내용을 입력하세요.")
                                .foregroundColor(.gray)
                                .foregroundColor(Color("TextColor"))
                                .padding(.top, 12)
                                .padding(.leading, 12)
                        }
                        
                        TextEditor(text: $wordDefinition)
                            .foregroundColor(Color("TextColor"))
                            .padding(.horizontal, 8)
                            .padding(.top, 4)
                            .textEditorStyle(.plain)
                    }
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("DarkModeBorder"), lineWidth: 2)
                    )
                    .cornerRadius(10)
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .sheet(isPresented: $isShowingTagSheet) {
                
                TagListSheetView(isTagSheetOpen: $isShowingTagSheet, selectedTagName: $tag)
            }
            
        }
    }
}

#Preview {
    CreateView()
}
