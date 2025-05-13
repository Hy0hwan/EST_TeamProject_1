//
//  Word.swift
//  Team7
//
//  Created by Kitcat Seo on 5/11/25.
//

import Foundation
import SwiftData

@Model

final class Word {
    var wordName: String // 단어 이름
    var wordDefinition: String // 단어 뜻
    var tag: String? // 태그, 옵셔널 항목이므로 사용 시에는 unwrapping 필요
    var createdAt: Date // 생성일
    
    init(
        wordName: String,
        wordDefinition: String,
        tag: String?,
        createdAt: Date = .now // 데이터 생성 시에 생성일이 자동으로 입력
    ) {
        self.wordName = wordName
        self.wordDefinition = wordDefinition
        self.tag = tag
        self.createdAt = createdAt
    }
}
