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
    var createdAt: Date // 생성일
    var tagColor: String // 태그 색상
    
    init(
        name: String,
        createdAt: Date = .now, // 데이터 생성 시에 생성일이 자동으로 입력
        tagColor: String = TagColors.allCases.randomElement()?.rawValue ?? "red" // 태그 색상 기본값 지정
    ) {
        self.name = name
        self.createdAt = createdAt
        self.tagColor = tagColor
    }
}
