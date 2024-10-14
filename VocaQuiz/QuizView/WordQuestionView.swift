import SwiftUI

struct WordQuestionView: View {
    @State var isAnswerCorrect: Bool = false
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
            VStack(spacing: 30) {
                if let quizItem = viewModel.quizWord {
                    Text("\(quizItem.word)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [
                                                    Color(red: 76/255, green: 175/255, blue: 80/255, opacity: 0.5),
                                                    Color(red: 56/255, green: 142/255, blue: 60/255, opacity: 0.7)
                                                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(10)
                        .shadow(radius: 8)

                    TextField("解答入力", text: $viewModel.userAnswer)
                        .padding()
                        .background(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                        .shadow(radius: 5)

                    Button {
                        viewModel.userAnswerCorreckCheck(userAnswer: viewModel.userAnswer, quizType: .wordContentToAnswer)
                        isAnswerCorrect = true
                    } label: {
                        Text("解答する")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                            .padding()
                            .background(viewModel.isButtonEnable ?
                                        Color.gray : Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 50)
                    .disabled(viewModel.isButtonEnable)
                    .sheet(isPresented: $isAnswerCorrect, onDismiss: {
                        viewModel.userAnswer = ""
                    }) {
                        if(viewModel.isAnswerCorrect) {
                            Text("正解")
                                .font(.system(size: 60))
                            Button() {
                                viewModel.onTapNextQuiz()
                                viewModel.userAnswer = " "
                                isAnswerCorrect = false
                            } label: {
                                Text("次の問題へ")
                                .font(.headline)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                                .padding()
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                            }
                            .padding(.top, 20)
                        } else {
                            Text("不正解")
                                .font(.system(size: 60))
                            Text("正解は\(quizItem.content)")

                            Button() {
                                viewModel.onTapNextQuiz()
                                viewModel.userAnswer = " "
                                isAnswerCorrect = false
                            } label: {
                                Text("次の問題へ")
                                .font(.headline)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                                .padding()
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                            }
                            .padding(.top, 20)
                        }
                    }
                } else {
                    Text("問題終了")
                }
            }
            .onAppear() {
                viewModel.onTapNextQuiz()
            }
        }
}
