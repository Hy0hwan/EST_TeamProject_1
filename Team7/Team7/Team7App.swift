//
//  Team7App.swift
//  Team7
//
//  Created by 김효환 on 5/9/25.
//

import SwiftUI
import SwiftData

@main
struct Team7App: App {
// ModelContainer 에러 처리를 위해 작성했으나 프리뷰에서 자꾸 오류가 나서 주석 처리
//    let container: ModelContainer

//    init() {
//        do {
//            container = try ModelContainer(for: Tag.self, Word.self)
//        } catch {
//            print("ModelContainer initialization failed with error: \(error)")
//            fatalError("Failed to create ModelContainer: \(error)")
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
        .modelContainer(
            try! ModelContainer(for: Tag.self, Word.self) // 기존과 같이 강제 초기화
        )
//        .modelContainer(container)
    }
}

