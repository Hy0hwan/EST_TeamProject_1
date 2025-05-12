//
//  MainPageView.swift
//  Team7
//
//  Created by 이유정 on 5/12/25.
//

import SwiftUI


class WordStore: ObservableObject {
    @Published var words: [String] = []

    init() {
        self.words = ["단어1", "단어2", "단어3"]
    }

    func addWord(_ word: String) {
        words.append(word)
    }
}


struct MainListView: View {
    @State private var searchText: String = ""
    @State private var wordStore = WordStore()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // title
            Text("단어 목록")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 24)

            // search bar
            HStack {
                TextField("검색하실 단어를 입력하세요", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())

                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4)))
            .padding(.horizontal)


            // 필터링
            Text("필터링")
                .font(.subheadline)
                .padding(.leading)
            Spacer()

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(wordStore.words.filter {
                        searchText.isEmpty ? true : $0.localizedStandardContains(searchText)
                    }, id: \.self) { word in
                        Text(word)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.cyan))
                            )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                    }
                    
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    MainListView()
}

