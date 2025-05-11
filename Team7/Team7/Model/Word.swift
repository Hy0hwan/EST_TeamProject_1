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
    var wordName: String
    var wordDefinition: String
    var tag: Tag?
    var createdAt: Date
    
    init(wordName: String, wordDefinition: String, tag: Tag?, createdAt: Date = .now) {
        self.wordName = wordName
        self.wordDefinition = wordDefinition
        self.tag = tag
        self.createdAt = createdAt
    }
}
