//
//  WordRowView.swift
//  Team7
//
//  Created by 이유정 on 5/12/25.
//

import SwiftUI

struct WordRowView: View {
    let word: Word

    var body: some View {
        HStack {
            Text(word.wordName)
                .foregroundColor(.primary)
            Spacer()
            if let tag = word.tag {
                TagContainerView(tag: tag, isButtonType: false)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
    }
}


#Preview {
    // 샘플 태그 생성
    let sampleTag = "문법"
    let sampleWord = Word(
        wordName: "옵셔널",
        wordDefinition: "값이 있을 수도, 없을 수도 있는 타입.",
        tag: sampleTag
    )
    WordRowView(word: sampleWord)
}

