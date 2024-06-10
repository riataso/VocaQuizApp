//
//  WordListViewModel.swift
//  VocaQuiz
//
//  Created by 佐藤来 on 2024/05/26.
//

import Foundation

class WordListViewModel: ObservableObject {
    @Published var wordList: WordList = .init(items: [])
    @Published var inputContent: String = ""
    @Published var inputWord: String = ""
    @Published var isCustomDialogShowing: Bool = false

    private let useCase = WordListUseCase.self

    func onTapCreateButton() {
        wordList = useCase.createWordItem(content: inputContent,word: inputWord, wordList: wordList)
    }

    func onTapDeleteButton(id: UUID) {
        wordList = useCase.deleteTask(id: id, wordList: wordList)
    }

    //入力欄の状態によってボタンを表示・非表示にする
    var isButtonEnable: Bool {
        inputWord.isEmpty || inputContent.isEmpty
    }

    // MARK: -Dialog制御メソッド
    func setNeedsToShowDialog() {
        isCustomDialogShowing = true
    }

    func setNeedsToHideDialog() {
        isCustomDialogShowing = false
    }
}
