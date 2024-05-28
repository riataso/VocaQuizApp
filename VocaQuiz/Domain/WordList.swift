//
//  WordList.swift
//  VocaQuiz
//
//  Created by 佐藤来 on 2024/05/19.
//

import Foundation

struct WordList {
    let items: [WordItem]

    init(items: [WordItem]) {
        self.items = items
    }

    func add(item: WordItem) -> WordList {
        let newItems = self.items + [item]
        return WordList(items: newItems)
    }

    func delete(id: UUID) -> WordList {
        let newItems = self.items.filter { wordItem in
            wordItem.id != id
        }
        return WordList(items: newItems)
    }
}
