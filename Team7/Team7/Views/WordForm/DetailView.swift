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

    @State private var isShowingEdit = false  // 수정 화면 전환용

    var word: Word
    var onDeleted: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button("삭제") {
                    context.delete(word)
                    try? context.save()
                    print("삭제 성공: \(word.wordName)")
                    onDeleted?()
                    dismiss()
                }
                
                Spacer()

                Button("수정") {
                    isShowingEdit = true  // 수정 버튼 누르면 상태 변경
                }
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

            // 수정 화면으로 이동하는 NavigationLink
            NavigationLink(destination: UpdateView(existingWord: word), isActive: $isShowingEdit) {
                EmptyView()
            }
            .hidden()
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter.string(from: date)
    }
}



#Preview {
    let previewWord = Word(
        wordName: "단어 제목",
        wordDefinition: "뜻",
        tag: "태그",
        createdAt: .now
    )
    return DetailView(word: previewWord)
}
// temporary comment for PR
