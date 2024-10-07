import SwiftUI

struct MainView: View {
    @StateObject var viewModel = WordViewModel(wordItemUseCase: WordItemUseCase())

    var body: some View {
        NavigationStack {
            VStack {
                Button {

                } label: {
                    NavigationLink(destination: SelectQuizTypeView()) {
                        Text("問題を解く")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 2/3)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [
                                                        Color(red: 76/255, green: 175/255, blue: 80/255, opacity: 0.5),
                                                        Color(red: 56/255, green: 142/255, blue: 60/255, opacity: 0.7)
                                                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 4)
                    }

                }
                .padding(.horizontal, 16)
            }

            Spacer()
                .frame(height: 40)

            NavigationLink(destination: CreateQuestionView(viewModel: viewModel)) {
                Text("問題を編集")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 2/3)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                                                Color(red: 100/255, green: 181/255, blue: 246/255, opacity: 0.5),
                                                Color(red: 25/255, green: 118/255, blue: 210/255, opacity: 0.7)
                                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 4)
            }
            .padding(.horizontal, 16)
        }
    }
}

//#Preview {
//    MainView()
//}
