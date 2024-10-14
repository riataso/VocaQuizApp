import SwiftUI

struct SelectQuizTypeView: View {
    @StateObject var viewModel = QuizViewModel()
    @State private var isActive: Bool = false
    @State private var selectedFormat: QuizType?
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if isActive {
                    QuestionView(selectedQuizType: $selectedFormat,viewModel: viewModel)
                } else {
                    Text("問題タイプを選ぶ")
                    Button {
                        viewModel.resetQuiz()
                        isActive.toggle()
                        selectedFormat = .wordToAnswer
                    } label: {
                        Text("単語を解答する")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray5)) 
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    
                    Button {
                        viewModel.resetQuiz()
                        isActive = true
                        selectedFormat = .wordContentToAnswer
                    } label: {
                        Text("単語内容を解答する")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                }
            }
            .padding()
        }
    }
}

enum QuizType{
    case wordToAnswer
    case wordContentToAnswer
}

