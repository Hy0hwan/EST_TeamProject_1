//
//  MainListView.swift
//  Team7
//
//  Created by 이유정 on 5/13/25.
//

import SwiftUI
import SwiftData

struct MainListView: View {
    @Environment(\.modelContext) private var context
    @Query var words: [Word]
    @State private var searchText: String = ""
    @State private var isShowingCreateView = false
    @State private var selectedWord: Word? = nil

    var filteredWords: [Word] {
        if searchText.isEmpty {
            return words
        } else {
            return words.filter { $0.wordName.localizedStandardContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("단어 목록")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)

                    Spacer()

                    // 검색창
                    HStack {
                        TextField("검색할 단어를 입력하세요", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.vertical, 8)
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.4)))
                    .padding(.horizontal)


                    Text("태그")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.leading)

                    // 태그 필터 바 (선택)
                    TagFilterView(words: words)

                    // 단어 리스트
                    List {
                            ForEach(filteredWords) { word in
                                // 단어 카드를 누르면 상세화면으로 이동 (임시 Text)
                                Button {
                                    selectedWord = word
                                } label: {
                                    WordRowView(word: word)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        deleteWord(word)
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    .listStyle(.plain)
                    }

                    Spacer()
                

                // 오른쪽 아래 +버튼
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isShowingCreateView = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.black)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            }
            // 단어 상세화면으로 이동 (임시 화면)
            .navigationDestination(item: $selectedWord) { word in
                // 실제 상세화면 구현은 X, 임시로 텍스트만
                Text("단어 상세화면 (임시)\n\(word.wordName)")
                    .font(.title)
                    .padding()
            }
            // 단어 추가화면으로 이동 (임시 화면)
            .sheet(isPresented: $isShowingCreateView) {
                // 실제 추가화면 구현은 X, 임시로 텍스트만
                Text("단어 추가화면 (임시)")
                    .font(.title)
                    .padding()
            }
            .navigationBarHidden(true)
        }
    }

    func deleteWord(_ word: Word) {
        context.delete(word)
        try? context.save()
    }
}

#Preview {
    MainListView()
}
