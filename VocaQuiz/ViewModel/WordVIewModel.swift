import Foundation

class WordViewModel: ObservableObject{
    @Published var wordItem : [WordEntity] = []
    @Published var isCustomDialogShowing: Bool = false
    @Published var inputContent: String = ""
    @Published var inputWord: String = ""

    private var wordItemUseCase: WordItemUseCase

    init(wordItemUseCase: WordItemUseCase) {
        self.wordItemUseCase = wordItemUseCase
    }

    @MainActor
    func createWordItem(_ word: String, _ content: String){
        wordItemUseCase.onTapCreateButton(word, content)
    }

    @MainActor
    func getWordItem(_ id: UUID) -> [WordEntity]{
        return wordItemUseCase.fetchWordItem(id)
    }

    @MainActor
    func allGetWordItem() -> [WordEntity]{
        return wordItemUseCase.fetchWordItems()
    }

    //入力欄の状態によってボタンを表示・非表示にする
    var isButtonEnable: Bool {
        inputWord.isEmpty || inputContent.isEmpty
    }

    // MARK: -Dialog制御メソッド
    func setNeedsToShowDialog(isShow: Bool) {
        isCustomDialogShowing = isShow ? false : true
    }
}
