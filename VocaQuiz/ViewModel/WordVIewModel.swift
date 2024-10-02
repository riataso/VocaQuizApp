import Foundation

class WordViewModel: ObservableObject{
    @Published var wordItem: WordEntity?
    @Published var wordItems: [WordEntity]?
    @Published var isCustomDialogShowing: Bool = false
    @Published var inputContent: String = ""
    @Published var inputWord: String = ""

    private var wordItemUseCase: WordItemUseCase

    init(wordItemUseCase: WordItemUseCase) {
        self.wordItemUseCase = wordItemUseCase
    }

    @MainActor
    func onCreateItem(_ word: String, _ content: String) {
        wordItemUseCase.createWordItem(word, content)
    }

    @MainActor
    func onDeleteItem(_ id: UUID) async {
        await wordItemUseCase.deleteWordItem(id)
    }

    @MainActor
    func lordWord() {
        wordItems = allGetWordItem()
    }

    @MainActor
    func getWordItem(_ id: UUID) async {
        do {
            let wordData = try await wordItemUseCase.fetchWordItem(id)
            self.wordItem = wordData
        } catch {
            print("値の取得に失敗しました: \(error)")
        }
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

    // ViewModelが再利用される場合にデータをリセットするメソッド
    func resetId() {
        self.wordItem = nil
    }
}
