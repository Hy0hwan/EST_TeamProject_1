//
//  SeedDataInsertView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/11/25.
//

import SwiftUI
import SwiftData

// 50건의 시드 데이터를 주입하기 위해 임시로 사용하는 뷰
struct SeedDataInsertView: View {
    @Environment(\.modelContext) var context
    @State private var words: [Word] = []
    
    var body: some View {
        VStack {
            // 시드 데이터 주입
            Button {
                insertSeedWords(context: context)
            } label: {
                Text("시드 데이터 주입하기")
            }
            .buttonStyle(.borderedProminent)
            
            // 시드 데이터 삭제
            Button(role: .destructive) {
                eraseAllSeedWords(context: context)
            } label: {
                Text("시드 데이터 삭제하기")
            }
            .buttonStyle(.borderedProminent)
            
            // 등록된 데이터를 표기
            List {
                Section("시드 데이터 리스트") {
                    ForEach(words, id: \.self) { word in
                        Text("\(word.wordName) : \(word.wordDefinition)")
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                loadWords() // 뷰 초기화 시 등록된 데이터 불러오기
            }
        }
        .padding()
    }
}

extension SeedDataInsertView {
    // 데이터 불러오기
    func loadWords() {
        let fetchDescriptor = FetchDescriptor<Word>()
        if let fetchedWords = try? context.fetch(fetchDescriptor) {
            self.words = fetchedWords
        }
    }
    
    // 데이터 주입하기
    func insertSeedWords(context: ModelContext) {
        // 이미 데이터가 있다면 종료 (예: Word가 1개 이상 있을 경우)
        let existingWords = try? context.fetch(FetchDescriptor<Word>())
        if let existingWords, !existingWords.isEmpty {
            print("⚠️ 이미 \(existingWords.count) 개의 단어 데이터가 존재합니다. 더미 데이터를 삽입하지 않습니다.")
            return
        }
        
        // 더미 데이터 - 태그
        let dummyTags = [
            Tag(name: "문법"),
            Tag(name: "UI"),
            Tag(name: "비동기")
        ]
        
        for tag in dummyTags {
            context.insert(tag)
        }
        
        // 더미 데이터 - 단어
        let dummyWords = [
            Word(wordName: "옵셔널", wordDefinition: "값이 있을 수도, 없을 수도 있는 타입.", tag: "문법"),
            Word(wordName: "뷰", wordDefinition: "사용자 인터페이스를 구성하는 요소.", tag: "비동기"),
            Word(wordName: "비동기", wordDefinition: "작업이 동시에 진행되며 완료될 때까지 기다리지 않는 방식.", tag: "비동기"),
            Word(wordName: "프리뷰", wordDefinition: "UI를 실시간으로 미리 보는 기능.", tag: "비동기"),
            Word(wordName: "상태", wordDefinition: "뷰의 동작이나 표현을 제어하는 변수.", tag: "비동기"),
            Word(wordName: "클로저", wordDefinition: "변수를 캡처할 수 있는 코드 블록.", tag: "문법"),
            Word(wordName: "프로퍼티 래퍼", wordDefinition: "@State, @Binding 등 속성을 감싸는 래퍼.", tag: "문법"),
            Word(wordName: "모델", wordDefinition: "데이터를 표현하는 구조체 또는 클래스.", tag: nil),
            Word(wordName: "NavigationStack", wordDefinition: "뷰 간의 이동을 관리하는 스택 기반 네비게이션 구조.", tag: "비동기"),
            Word(wordName: "Task", wordDefinition: "비동기 작업을 실행하는 단위.", tag: "비동기"),
            Word(wordName: "옵셔널 체이닝", wordDefinition: "옵셔널 값이 존재할 경우에만 속성, 메서드, 서브스크립트에 접근하는 문법.", tag: "문법"),
            Word(wordName: "강제 언래핑", wordDefinition: "옵셔널 값이 nil이 아님을 확신하고 '!'를 사용해 값을 꺼내는 방식.", tag: "문법"),
            Word(wordName: "옵셔널 바인딩", wordDefinition: "if let 또는 guard let으로 옵셔널을 안전하게 꺼내는 방법.", tag: "문법"),
            Word(wordName: "AnyView", wordDefinition: "타입을 숨겨 여러 다른 뷰를 같은 컨텍스트에 사용할 수 있도록 하는 래퍼 뷰.", tag: "UI"),
            Word(wordName: "NavigationLink", wordDefinition: "다른 뷰로 이동할 수 있는 네비게이션 요소.", tag: "UI"),
            Word(wordName: "ObservableObject", wordDefinition: "뷰 모델에서 상태를 공유할 수 있도록 하는 프로토콜.", tag: "문법"),
            Word(wordName: "Published", wordDefinition: "ObservableObject에서 속성의 변경을 알리는 속성 래퍼.", tag: "문법"),
            Word(wordName: "Binding", wordDefinition: "부모 뷰와 자식 뷰 사이에서 상태를 공유할 수 있는 속성 래퍼.", tag: "문법"),
            Word(wordName: "StateObject", wordDefinition: "뷰에서 소유하고 관리하는 상태 객체를 선언할 때 사용하는 속성 래퍼.", tag: "문법"),
            Word(wordName: "EnvironmentObject", wordDefinition: "앱 전역에서 공유하는 상태 객체를 주입받을 때 사용하는 속성 래퍼.", tag: "문법"),
            Word(wordName: "Form", wordDefinition: "설정 화면 등에서 자주 쓰이는 리스트 기반 UI 레이아웃.", tag: "UI"),
            Word(wordName: "ScrollView", wordDefinition: "스크롤 가능한 컨테이너 뷰.", tag: "UI"),
            Word(wordName: "GeometryReader", wordDefinition: "레이아웃의 위치와 크기 정보를 읽어올 수 있는 뷰.", tag: "UI"),
            Word(wordName: "Spacer", wordDefinition: "여백을 만들어주는 뷰 레이아웃 도우미.", tag: "UI"),
            Word(wordName: "Animation", wordDefinition: "뷰의 변화에 애니메이션 효과를 추가하는 기능.", tag: "UI"),
            Word(wordName: "Transition", wordDefinition: "뷰의 삽입/삭제 시 애니메이션을 정의하는 기능.", tag: "UI"),
            Word(wordName: "onAppear", wordDefinition: "뷰가 화면에 나타날 때 호출되는 이벤트.", tag: "UI"),
            Word(wordName: "onDisappear", wordDefinition: "뷰가 화면에서 사라질 때 호출되는 이벤트.", tag: "UI"),
            Word(wordName: "Task", wordDefinition: "비동기 코드를 실행하기 위한 기본 단위.", tag: "비동기"),
            Word(wordName: "async/await", wordDefinition: "비동기 코드를 동기 코드처럼 작성할 수 있는 구문.", tag: "비동기"),
            Word(wordName: "MainActor", wordDefinition: "메인 스레드에서 실행되도록 보장하는 속성 또는 컨텍스트.", tag: "비동기"),
            Word(wordName: "TaskGroup", wordDefinition: "여러 개의 비동기 작업을 동시에 실행하고 결과를 모으는 구조.", tag: "비동기"),
            Word(wordName: "withTaskCancellationHandler", wordDefinition: "비동기 작업이 취소될 때 클린업 코드를 실행할 수 있도록 함.", tag: "비동기"),
            Word(wordName: "Error", wordDefinition: "Swift의 에러 처리 프로토콜.", tag: "문법"),
            Word(wordName: "try?", wordDefinition: "오류가 발생할 경우 nil을 반환하는 옵셔널 try 구문.", tag: "문법"),
            Word(wordName: "try!", wordDefinition: "오류가 발생하지 않는다고 확신할 때 사용하는 위험한 try 구문.", tag: "문법"),
            Word(wordName: "guard", wordDefinition: "조건이 충족되지 않으면 빠르게 탈출하는 제어 구문.", tag: "문법"),
            Word(wordName: "if let", wordDefinition: "옵셔널을 안전하게 언래핑할 때 사용하는 조건문.", tag: "문법"),
            Word(wordName: "LazyVStack", wordDefinition: "필요할 때만 그려지는 수직 스택 뷰.", tag: "UI"),
            Word(wordName: "List", wordDefinition: "표 형태로 데이터를 나열하는 기본 UI 요소.", tag: "UI"),
            Word(wordName: "HStack", wordDefinition: "수평 방향으로 뷰를 배치하는 컨테이너 뷰.", tag: "UI"),
            Word(wordName: "ZStack", wordDefinition: "뷰를 겹쳐서 배치할 때 사용하는 컨테이너 뷰.", tag: "UI"),
            Word(wordName: "Observable", wordDefinition: "값이 바뀔 때마다 알림을 받을 수 있는 객체.", tag: "문법"),
            Word(wordName: "Button", wordDefinition: "사용자와의 상호작용을 위한 터치 가능한 UI 요소.", tag: "UI"),
            Word(wordName: "Toggle", wordDefinition: "켜짐/꺼짐 상태를 가진 스위치 UI 요소.", tag: "UI"),
            Word(wordName: "Picker", wordDefinition: "선택지를 선택할 수 있는 UI 요소.", tag: "UI"),
            Word(wordName: "DatePicker", wordDefinition: "날짜나 시간을 선택할 수 있는 UI 요소.", tag: "UI"),
            Word(wordName: "Alert", wordDefinition: "간단한 메시지를 보여주는 경고창.", tag: "UI"),
            Word(wordName: "Sheet", wordDefinition: "하단에서 올라오는 모달 뷰.", tag: "UI"),
            Word(wordName: "FullScreenCover", wordDefinition: "전체 화면을 덮는 모달 뷰.", tag: "UI")
        ]
        
        for word in dummyWords {
            context.insert(word)
        }
        
        try? context.save()
        
        loadWords() // 데이터 등록 후 한 번 더 불러와 뷰에 반영하기
        print("더미 데이터 주입 성공")
    }
    
    // 데이터 삭제하기
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
