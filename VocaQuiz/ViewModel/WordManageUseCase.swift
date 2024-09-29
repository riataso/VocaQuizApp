//
//  WordManageUseCase.swift
//  VocaQuiz
//
//  Created by 佐藤来 on 2024/09/20.
//

import Foundation

class WordItemUseCase {
    private let repository = WordRepository()

    @MainActor
    func onTapCreateButton(_ word: String,_ content: String) {
        repository.create(word, content)
    }

    @MainActor
    func fetchWordItems() -> [WordEntity] {
        return repository.fetchAll()
    }

    @MainActor
    func fetchWordItem(_ id: UUID) -> [WordEntity] {
        return repository.fetch(targetId: id)
    }
}

