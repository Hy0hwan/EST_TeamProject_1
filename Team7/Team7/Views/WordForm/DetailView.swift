//
//  WordFormView2.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//
import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingEdit = false
    @State private var showDeleteAlert = false
    
    var word: Word
    var onDeleted: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showDeleteAlert = true
                } label: {
                    Text("삭제")
                }
                
                Spacer()
                
                Button {
                    isShowingEdit = true
                } label: {
                    Text("수정")
                }
            }
            .padding(.horizontal)
            
            Text("단어 상세")
                .font(.title2)
                .bold()
                .frame(height: 20)
            
            HStack(spacing: 4) {
                Text(word.wordName)
                    .font(.body)
                Spacer()
                if let tag = word.tag {
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
            
            NavigationLink(
                destination: UpdateView(existingWord: word, isUpdatePresent: $isShowingEdit),
                isActive: $isShowingEdit
            ) {
                EmptyView()
            }
            .hidden()
        }
        
        .alert("삭제하시겠습니까?", isPresented: $showDeleteAlert) {
            Button(role: .destructive) {
                context.delete(word)
                try? context.save()
                onDeleted?()
                dismiss()
            } label: {
                Label("삭제", systemImage: "trash")
            }
            
            Button(role: .cancel) {
                
            } label: {
                Label("취소", systemImage: "xmark")
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter.string(from: date)
    }
}

#Preview {
    DetailView(word: Word(wordName: "예제 단어",wordDefinition: "예제 뜻",
    tag: "예제태그",createdAt: .now))
}


