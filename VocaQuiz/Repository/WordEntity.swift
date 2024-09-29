//
//  WordEntity.swift
//  VocaQuiz
//
//  Created by 佐藤来 on 2024/09/21.
//

import Foundation
import SwiftData

@Model
class WordEntity: Identifiable {
    public var id: UUID
    public var content: String
    public var word: String

    init(id: UUID, content: String, word: String) {
        self.id = id
        self.content = content
        self.word = word
    }
}
