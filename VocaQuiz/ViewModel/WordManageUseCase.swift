//
//  WordManageUseCase.swift
//  VocaQuiz
//
//  Created by 佐藤来 on 2024/09/20.
//

import Foundation

import Foundation

struct WordManageUseCase {

    static func createWordItem(content: String, word: String, wordList: WordList) -> WordList {
        let newWordItem = WordItem(id: UUID(), content: content, word: word)
        return wordList.add(item: newWordItem)
    }

    static func deleteTask(id: UUID, wordList: WordList) -> WordList {
        return wordList.delete(id: id)
    }
}
