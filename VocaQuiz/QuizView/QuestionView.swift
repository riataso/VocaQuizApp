import SwiftUI

struct QuestionView: View {
    @Binding var selectedQuizType: QuizType?
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            if let selectedQuizType = selectedQuizType {
                switch selectedQuizType {
                case .wordToAnswer:
                    WordQuestionView(viewModel: viewModel)
                case .wordContentToAnswer:
                    ContentQuestionView(viewModel: viewModel)
                }
            } else {
                Text("読み込み失敗")
            }
        }
    }
}
