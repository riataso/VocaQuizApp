import SwiftUI

struct CreateQuestionView: View {
    @ObservedObject var viewModel: WordViewModel
    @State var isPresented = false
    @State var path = NavigationPath()

    var body: some View {

        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.allGetWordItem()) { item in
                            NavigationLink(destination: WordManageView(viewModel: viewModel, wordId: item.id)){
                                Text("\(item.word)")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("問題一覧")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.setNeedsToShowDialog(isShow: isPresented)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .fullScreenCover(isPresented: $viewModel.isCustomDialogShowing) {
                    PopupView(isPresented: $viewModel.isCustomDialogShowing, viewModel: viewModel)
                }
            }
            .onAppear {
                //再描画のタイミングで再取得する
                viewModel.lordWord()
            }
        }
    }

//    struct TaskListView_Previews: PreviewProvider {
//
//        static var previews: some View {
//            let viewModel:  WordViewModel(wordItemUseCase: WordItemUseCase())
//            CreateQuestionView(viewModel: viewModel)
//        }
//    }

    struct PopupView: View {
        @Binding var isPresented: Bool
        @ObservedObject var viewModel: WordViewModel

        var body: some View {
            ZStack {
                // 背景を全画面に表示
                Color.black.opacity(0.75)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }

                // ポップアップ内容を中央に表示
                VStack {
                    PopupContentsView(isPresented: $isPresented, viewModel: viewModel)
                        .frame(maxWidth: .infinity) // 幅を全体に設定
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding(20)
                }
                .padding()
            }
            .transition(.move(edge: .bottom)) // 下から表示されるアニメーション
            .animation(.easeInOut, value: isPresented) // アニメーションを適用
        }
    }
    // MARK: - ポップアップの内容
    struct PopupContentsView: View {
        @Binding var isPresented: Bool
        @ObservedObject var viewModel: WordViewModel

        var body: some View {
            VStack {
                Text("単語を作成")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)

                VStack(alignment: .leading) {
                    Text("問題単語")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("単語を入力してください", text: $viewModel.inputWord)
                        .padding(.bottom, 5)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.red),
                            alignment: .bottom
                        )
                        .padding(.bottom, 20)

                    Text("問題内容・詳細")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("単語内容を入力してください", text: $viewModel.inputContent)
                        .padding(.bottom, 5)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.red),
                            alignment: .bottom
                        )
                        .padding(.bottom, 20)
                }
                HStack {
                    Button {
                        isPresented = false
                    } label: {
                        Text("閉じる")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 5)

                    Button {
                        viewModel.onCreateItem(viewModel.inputWord, viewModel.inputContent)
                        isPresented = false
                        viewModel.inputContent = ""
                        viewModel.inputWord = ""
                    } label: {
                        Text("作成")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.isButtonEnable ? Color.gray : Color.red)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isButtonEnable)
                    .padding(.horizontal, 5)
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}
