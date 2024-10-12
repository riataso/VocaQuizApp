import Foundation

@MainActor
class QuizViewModel: ObservableObject {
    @Published var quizWord: WordEntity?
    @Published var quizItem: [WordEntity] = []

    //次の問題を出題する処理
    func onTapNextQuiz() -> WordEntity? {
        if quizItem.isEmpty { return nil }
        var index: Int = Int.random(in: 0 ..< quizItem.count)
        quizWord = quizItem.remove(at: index)
        return quizWord
    }

    //問題を初期化する処理
    func resetQuiz() {
        quizItem = WordRepository.shared.fetchAll()
    }

    //解答結果が合っているか確認するメソッド
    func userAnswerCorreckCheck(userAnswer: String, quizType: QuizType) -> Bool {
        switch quizType {
        case .wordToAnswer:
            return   userAnswer == quizWord?.word
        case .wordContentToAnswer:
            return   userAnswer == quizWord?.content
        }
    }
}
