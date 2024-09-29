//
//  WordRepository.swift
//  VocaQuiz
//
//  Created by 佐藤来 on 2024/09/20.
//

import Foundation
import SwiftData

class WordRepository {
    private let modelContainer = try? ModelContainer(for: WordEntity.self)
    
    @MainActor
    func create(_ word: String, _ content: String) {
        let wordItem = WordEntity(id: UUID(), content: content,word: word)
        modelContainer?.mainContext.insert(wordItem)
    }

    @MainActor
    func fetchAll() -> [WordEntity] {
        let descriptor = FetchDescriptor<WordEntity>()
        let fetchItems = try? modelContainer?.mainContext.fetch(descriptor)
                guard let fetchItems else {
                    // TODO: ハンドリング
                    return []
                }
                return fetchItems
    }

    @MainActor
    func fetch(targetId: UUID) -> [WordEntity] {
        return fetchAll().filter{ $0.id == targetId }
    }

}


