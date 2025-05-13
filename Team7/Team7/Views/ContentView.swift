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
    
    @State var selectedTag = Tag(name: "문법") // 지금은 문법 태그로 고정해놨지만, 실제 사용할 때는 단어의 태그 ( word.tag?.name ) 로 대체하기
    
    var body: some View {
        
        VStack {
            // 최초에 더미 데이터를 주입하는 버튼입니다.
            // 주입하신 이후에는 사용할 필요가 없으니 주석 처리 해주세요.
            NavigationStack {
                VStack {
//                    Button {
//                        isSeedDataViewOpen = true
//                    } label: {
//                        Text("시드 데이터 관리하기")
//                    }
                    MainListView()
                    Button {
                        isTagSheetOpen = true
                    } label: {
                        TagDisplayView(tag: $selectedTag, isEditable: true)
                    }
                }
                .navigationDestination(isPresented: $isSeedDataViewOpen) {
                    SeedDataInsertView()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
