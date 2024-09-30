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
