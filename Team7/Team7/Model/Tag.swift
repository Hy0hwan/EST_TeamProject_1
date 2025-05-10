//
//  Tag.swift
//  Team7
//
//  Created by Kitcat Seo on 5/11/25.
//

import Foundation
import SwiftData

@Model

final class Tag {
    var name: String
    @Relationship(deleteRule: .nullify, inverse: \Word.tag)
    var createdAt: Date
    
    init(name: String, createdAt: Date = .now) {
        self.name = name
        self.createdAt = createdAt
    }
}
