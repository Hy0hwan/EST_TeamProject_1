//
//  TagFilterView.swift
//  Team7
//
//  Created by 이유정 on 5/13/25.
//

//
//  TagFilterView.swift
//  Team7
//
//  Created by 이유정 on 5/12/25.
//

import SwiftUI

struct TagFilterView: View {
    let words: [Word]

    var tags: [String] {


        Array(Set(words.compactMap { $0.tag }))
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                 //   TagContainerView(tag: tag, isButtonType: false)
                
                    
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    // 샘플 태그와 단어 준비
    let sampleTag1 = "문법"
    let sampleTag2 = "UI"
    let sampleWords = [
        Word(wordName: "옵셔널", wordDefinition: "값이 있을 수도, 없을 수도 있는 타입.", tag: sampleTag1),
        Word(wordName: "뷰", wordDefinition: "사용자 인터페이스를 구성하는 요소.", tag: sampleTag2)
    ]
    TagFilterView(words: sampleWords)
}
