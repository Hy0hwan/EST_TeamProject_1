//
//  MainListView.swift
//  Team7
//
//  Created by 이유정 on 5/13/25.
//

import SwiftUI
import SwiftData

struct MainListView: View {
    var monthName: String?
    
    @Environment(\.modelContext) private var context
    @Query var words: [Word]
    @State private var searchText: String = ""
    @State private var isShowingCreateView = false
    @State private var isShowingDetailView = false
    @State private var selectedWord: Word? = nil
    @State private var selectedTag: String? = nil
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())

    

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
                    .onAppear {
                        print("11 : \(monthName)")
                        // 데이터확인
                    }

                    MonthFilterBar(selectedYear: $selectedYear, selectedMonth: $selectedMonth)

                    Text("태그")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.leading)

                    // 태그 필터 바 (선택)
                    TagFilterView(words: words, selectedTag: $selectedTag)

                    // 단어 리스트
                    List {
                            ForEach(filteredWords) { word in
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
                                .listRowSeparator(.hidden)
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
                        Button(
                            action: { isShowingCreateView = true },
                            label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                    .padding()
                                    .background(Color("PlusButtonColor"))
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }
                        )
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            }
            // 단어 상세화면으로 이동
            .navigationDestination(item: $selectedWord) { word in
                DetailView(word: word)

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
