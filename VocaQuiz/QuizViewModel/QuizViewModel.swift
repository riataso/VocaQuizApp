import Foundation

@MainActor
class QuizViewModel: ObservableObject {
    @Published var quizWord: WordEntity?
    @Published var quizItem: [WordEntity] = []
    @Published var userAnswer: String = ""
    var isAnswerCorrect: Bool = false

    //次の問題を出題する処理
    func onTapNextQuiz() {
        if quizItem.isEmpty {
            quizWord = nil
        }else{
            let index: Int = Int.random(in: 0 ..< quizItem.count)
            quizWord = quizItem.remove(at: index)
        }
    }

    //問題を初期化する処理
    func resetQuiz() {
        quizItem = WordRepository.shared.fetchAll()
    }

    //解答結果が合っているか確認するメソッド
    func userAnswerCorreckCheck(userAnswer: String, quizType: QuizType) {
        switch quizType {
        case .wordToAnswer:
            if(userAnswer == quizWord?.word) {
                isAnswerCorrect = true
            } else {
                isAnswerCorrect = false
            }
        case .wordContentToAnswer:
            if(userAnswer == quizWord?.content) {
                isAnswerCorrect = true
            } else {
                isAnswerCorrect = false
            }
        }
    }

    //入力欄の状態によってボタンを表示・非表示にする
    var isButtonEnable: Bool {
        userAnswer.isEmpty
    }
}
