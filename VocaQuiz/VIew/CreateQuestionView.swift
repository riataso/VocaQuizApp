//
//  CreateQuestionView.swift
//  VocaQuiz
//
//  Created by 佐藤来 on 2024/05/28.
//

import SwiftUI

struct CreateQuestionView: View {
    @StateObject private var viewModel: WordListViewModel = .init()
    @State var isPresented = false
    @State var path = NavigationPath()

    var body: some View {

        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.wordList.items) { item in
                            HStack {
                                Text("\(item.word)")
                                Spacer()
                                Button {

                                } label: {
                                    Text(">")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("問題一覧")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.setNeedsToShowDialog()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                if viewModel.isCustomDialogShowing {
                    PopupView(isPresented: $viewModel.isCustomDialogShowing, viewModel: viewModel)
                }
            }
        }
     }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuestionView()
    }
}

struct PopupView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: WordListViewModel

    var body: some View {
        GeometryReader { geometry in

            ZStack {
                PopupBackgroundView(isPresented: isPresented)
                    .transition(.opacity)
                PopupContentsView(viewModel: viewModel, isPresented:$isPresented)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
                    .background(Color.white)
                    .cornerRadius(20)
            }
        }
    }
}

struct PopupBackgroundView: View {
    @State var isPresented: Bool

    var body: some View {
        Color.black.opacity(0.75)
            .onTapGesture {
                self.isPresented = false
            }
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: -タスクの追加画面
struct PopupContentsView: View {
    @ObservedObject var viewModel: WordListViewModel
    @Binding var isPresented: Bool

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
            HStack{
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
                    viewModel.onTapCreateButton()
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
    }
}
