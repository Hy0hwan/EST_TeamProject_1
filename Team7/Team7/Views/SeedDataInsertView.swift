//
//  SeedDataInsertView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/11/25.
//

import SwiftUI
import SwiftData

struct SeedDataInsertView: View {
    @Environment(\.modelContext) var context
    @State private var words: [Word] = []
    @State private var tags: [Tag] = []
    
    var body: some View {
        VStack {
            Button {
                insertSeedWords(context: context)
            } label: {
                Text("시드 데이터 주입하기")
            }
            .buttonStyle(.borderedProminent)
            
            Button(role: .destructive) {
                eraseAllSeedWords(context: context)
            } label: {
                Text("시드 데이터 삭제하기")
            }
            .buttonStyle(.borderedProminent)
            
            List {
                Section("시드 데이터 리스트") {
                    ForEach(words, id: \.self) { word in
                        Text("\(word.wordName) : \(word.wordDefinition) \n\(word.tag != nil ? word.tag!.name : "태그없음")")
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                loadWords()
            }
        }
    }
}

extension SeedDataInsertView {
    func loadWords() {
        // 데이터 불러오기
        let fetchDescriptor = FetchDescriptor<Word>()
        if let fetchedWords = try? context.fetch(fetchDescriptor) {
            self.words = fetchedWords
        }
    }
    
    func insertSeedWords(context: ModelContext) {
        // 이미 데이터가 있다면 종료 (예: Word가 1개 이상 있을 경우)
        let existingWords = try? context.fetch(FetchDescriptor<Word>())
        if let existingWords, !existingWords.isEmpty {
            print("⚠️ 이미 \(existingWords.count) 개의 단어 데이터가 존재합니다. 더미 데이터를 삽입하지 않습니다.")
            return
        }
        
        // 재사용할 태그 생성
        let dummyTags = [
            Tag(name: "문법"),
            Tag(name: "UI"),
            Tag(name: "비동기")
        ]
        
        for tag in dummyTags {
            context.insert(tag)
        }
        
        // 더미 데이터 등록하기
        let dummyWords = [
            Word(wordName: "옵셔널", wordDefinition: "값이 있을 수도, 없을 수도 있는 타입.", tag: Tag(name: "문법")),
            Word(wordName: "뷰", wordDefinition: "사용자 인터페이스를 구성하는 요소.", tag: Tag(name: "비동기")),
            Word(wordName: "비동기", wordDefinition: "작업이 동시에 진행되며 완료될 때까지 기다리지 않는 방식.", tag: Tag(name: "비동기")),
            Word(wordName: "프리뷰", wordDefinition: "UI를 실시간으로 미리 보는 기능.", tag: Tag(name: "비동기")),
            Word(wordName: "상태", wordDefinition: "뷰의 동작이나 표현을 제어하는 변수.", tag: Tag(name: "비동기")),
            Word(wordName: "클로저", wordDefinition: "변수를 캡처할 수 있는 코드 블록.", tag: Tag(name: "문법")),
            Word(wordName: "프로퍼티 래퍼", wordDefinition: "@State, @Binding 등 속성을 감싸는 래퍼.", tag: Tag(name: "문법")),
            Word(wordName: "모델", wordDefinition: "데이터를 표현하는 구조체 또는 클래스.", tag: nil),
            Word(wordName: "NavigationStack", wordDefinition: "뷰 간의 이동을 관리하는 스택 기반 네비게이션 구조.", tag: Tag(name: "비동기")),
            Word(wordName: "Task", wordDefinition: "비동기 작업을 실행하는 단위.", tag: Tag(name: "비동기"))
        ]
        
        for word in dummyWords {
            context.insert(word)
        }
        
        try? context.save()
        
        loadWords()
        print("더미 데이터 주입 성공")
    }
    
    func eraseAllSeedWords(context: ModelContext) {
        let descriptor = FetchDescriptor<Word>()
        
        if let words = try? context.fetch(descriptor) {
            for word in words {
                context.delete(word)
            }
            
            loadWords()
            try? context.save()
            print("📛 모든 Word 시드 데이터 삭제 완료")
        } else {
            print("❌ 데이터를 불러오는 데 실패했습니다.")
        }
    }
}

#Preview {
    SeedDataInsertView()
        .modelContainer(for: [Word.self, Tag.self])
}
