//
//  WordFormView2.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//

import SwiftUI

struct WordFormView2: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var word: Word

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button("삭제") {
                    context.delete(word)
                    try? context.save()
                    
                    dismiss()
                    
//                    Button("삭제") {
//                        context.delete(word)
//                        do {
//                            try context.save()
//                            print(" 삭제 성공: \(word.wordName)")
//                        } catch {
//                            print("삭제 실패: \(error)")
//                        }
//                        dismiss()
                    
                    
                }
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
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter.string(from: date)
    }
}

#Preview {
    WordFormView2(word: Word(wordName: "예시 단어", wordDefinition: "예시 뜻", tag: "예시 태그"))
}
