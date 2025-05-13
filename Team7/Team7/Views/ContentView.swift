//
//  ContentView.swift
//  Team7
//
//  Created by 김효환 on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    @State var isSeedDataViewOpen = false
    @State var isTagSheetOpen = false
    
    var words: [Word]
    var tags: [String] { Array(Set(words.compactMap { $0.tag })) }
    
    var body: some View {
        VStack {
            // 최초에 더미 데이터를 주입하는 버튼입니다.
            // 주입하신 이후에는 사용할 필요가 없으니 주석 처리 해주세요.
            NavigationStack {
                VStack {
                    Button {
                        isSeedDataViewOpen = true
                    } label: {
                        Text("시드 데이터 관리하기")
                    }
                    
                    ForEach(tags, id: \.self) { tag in
                        // 버튼으로 눌려야할 때
                        TagContainerView(tag: tag, isButtonType: true)
                        
                        // 보여주기만 할 때
                        TagContainerView(tag: tag, isButtonType: false)
                    }
                }
                .navigationDestination(isPresented: $isSeedDataViewOpen) {
                    SeedDataInsertView()
                }
            }
        }
        .onAppear {
        }
    }
}


#Preview {
    ContentView(
        words: [
            Word(wordName: "모델", wordDefinition: "데이터를 표현하는 구조체 또는 클래스.", tag: nil),
            Word(wordName: "NavigationStack", wordDefinition: "뷰 간의 이동을 관리하는 스택 기반 네비게이션 구조.", tag: "비동기")
        ]
    )
}
