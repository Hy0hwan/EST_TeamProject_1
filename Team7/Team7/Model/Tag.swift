//
//  Tag.swift
//  Team7
//
//  Created by Kitcat Seo on 5/11/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model

final class Tag {
    var name: String // 태그 이름
    /// 단어의 태그와 단어의 종속성 추가 : Word.tag 항목은 아무거나 입력할 수 없고, Tag 데이터 중 하나가 선택돼야 됨
//    @Relationship(deleteRule: .nullify, inverse: \Word.tag)
    var createdAt: Date // 생성일
    var tagColor: String // 태그 색상
    
    init(
        name: String,
        createdAt: Date = .now,
        tagColor: String = TagColors.red.rawValue // 태그 색상 기본값 지정
    ) {
        self.name = name
        self.createdAt = createdAt
        self.tagColor = tagColor
    }
}
