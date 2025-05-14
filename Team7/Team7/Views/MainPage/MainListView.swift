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
    @State private var isShowingWordFormView = false
    @State private var selectedWord: Word? = nil
    @State private var selectedTag: String? = nil

    var filteredWords: [Word] {
        words.filter { word in
            let matchesSearch = searchText.isEmpty || word.wordName.localizedStandardContains(searchText)
            let matchesTag = selectedTag == nil || word.tag == selectedTag
            return matchesSearch && matchesTag
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

                    // searchbar
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
                    TagFilterView(words: words, selectedTag: $selectedTag)

                    // 단어 리스트
                    List {
                            ForEach(filteredWords) { word in
                                // 상세화면으로 이동
                                Button {
                                    print("String")
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
            // 단어 상세화면으로 이동
            .navigationDestination(isPresented: $isShowingWordFormView) {
                WordFormView()
            }
            // 단어 추가화면으로 이동
            .navigationDestination(isPresented: $isShowingCreateView) {
                CreateView()
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
