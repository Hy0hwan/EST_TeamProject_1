//
//  AppView.swift
//  Team7
//
//  Created by 김효환 on 5/13/25.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            MainListView()
                .tabItem {
                    Image(systemName: "text.book.closed.fill")
                    Text("단어장")
                }

            ChartsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("통계")
                }
        }
        // 태그 관리 화면으로 가는 진입점이 없어서 임시로 추가해 놓음
<<<<<<< HEAD
        TagContainerView(isButtonType: true)
        ContentView()
=======
        TagContainerView(tag: "문법", isButtonType: true)
>>>>>>> 6934a2af0224c151c3c64125b89468aae7b6fa5d
    }
}

#Preview {
    AppView()
}
