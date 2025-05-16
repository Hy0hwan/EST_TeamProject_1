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
    @State var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var refreshID = UUID()


    func parseMonth(monthName: String?) -> (year: Int, month: Int)? {
        // 옵셔널 문자열이 nil이면 바로 종료
        guard let monthName = monthName else { return nil }

        // "2025년 7월" → "2025 7"
        // "년"과 "월"을 공백으로 바꾸고 공백 기준으로 분리
        let components = monthName
            .replacingOccurrences(of: "년", with: "")   // "2025년 7월" → "2025 7월"
            .replacingOccurrences(of: "월", with: "")   // "2025 7월" → "2025 7"
            .components(separatedBy: " ")              // "2025 7" → ["2025", "7"] 배열로 반환

        // 분리된 값이 정확히 2개이고, 둘 다 Int로 변환 가능한 경우
        if components.count == 2,
           let year = Int(components[0]),             // 첫 번째 요소 "2025" → 2025(Int)
           let month = Int(components[1]) {           // 두 번째 요소 "7" → 7(Int)
            return (year, month)                      // 튜플로 반환
        }

        // 파싱 실패한 경우 nil 반환
        return nil
    }


    var filteredWords: [Word] {
        words.filter { word in
            let date = word.createdAt
            let year = Calendar.current.component(.year, from: date)
            let month = Calendar.current.component(.month, from: date)
            let matchesMonth = (year == selectedYear) && (month == selectedMonth)

            let matchesSearch = searchText.isEmpty || word.wordName.localizedStandardContains(searchText)
            let matchesTag = selectedTag == nil || word.tag == selectedTag
            return matchesMonth && matchesSearch && matchesTag
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
                        print(monthName)
                        if let parsed = parseMonth(monthName: monthName) {
                            selectedYear = parsed.year
                            selectedMonth = parsed.month
                        }
                        print("년 : \(selectedYear)")
                        print("월 : \(selectedMonth)")
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
                                .id(refreshID)
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
            .onAppear {
                refreshID = UUID()
            }
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
