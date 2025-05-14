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
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: Tag.self, Word.self)
            print("성공 :  \(container)")
        } catch {
            fatalError("실패 : \(error)")

        }
    }

    var body: some Scene {
        WindowGroup {
            AppView()
        }
        .modelContainer(container)
    }
}


