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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(
            try! ModelContainer(for: Tag.self, Word.self)
        )
    }
}
