

import SwiftUI

struct WordManageView: View {
    @ObservedObject  var viewModel: WordViewModel
    @State var isPresented = false
    // TODO: WordEntityからの呼び出しをなくす(IDをもとに取得するよう変更)
    var wordItem: WordEntity


    var body: some View {
        VStack {
            List {
                Section(){
                    HStack {
                        Text("単語")
                            .font(.title3)
                        Text("\(wordItem.word)")
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                Section(){
                    HStack {
                        Text("単語内容")
                            .font(.title3)
                        Text("\(wordItem.content)")
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }

    }
}

struct PopupEditView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: WordViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                PopupBackgroundEditView(isPresented: isPresented)
                    .transition(.opacity)
                PopupContentsEditView(viewModel: viewModel, isPresented:$isPresented)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
                    .background(Color.white)
                    .cornerRadius(20)
            }
        }
    }
}

        struct PopupBackgroundEditView: View {
            @State var isPresented: Bool

            var body: some View {
                Color.black.opacity(0.75)
                    .onTapGesture {
                        self.isPresented = false
                    }
                    .edgesIgnoringSafeArea(.all)
            }
        }

        // MARK: -タスク編集画面
        struct PopupContentsEditView: View {
            @ObservedObject var viewModel: WordViewModel
            @Binding var isPresented: Bool

            var body: some View {
                VStack {
                    Text("単語内容を編集")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    VStack(alignment: .leading){
                        Text("問題単語")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        TextField("単語を入力してください", text: $viewModel.inputWord)
                            .frame(width: 250)
                            .padding(.bottom, 5)  // テキストフィールドと下線の間にスペースを追加
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)  // 下線の高さを設定
                                    .foregroundColor(.red),  // 下線の色を赤に設定
                                alignment: .bottom  // 下線をテキストフィールドの下に配置
                            )
                            .padding(.bottom, 20)
                        Text("問題内容・詳細")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        TextField("単語内容を入力してください", text: $viewModel.inputContent)
                            .frame(width: 250)
                            .padding(.bottom, 5)  // テキストフィールドと下線の間にスペースを追加
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)  // 下線の高さを設定
                                    .foregroundColor(.red),  // 下線の色を赤に設定
                                alignment: .bottom  // 下線をテキストフィールドの下に配置
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

                        } label: {
                            Text("更新")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(viewModel.isButtonEnable ? Color.gray : Color.red)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
        }
