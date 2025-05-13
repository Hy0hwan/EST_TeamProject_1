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
    }
}

#Preview {
    AppView()
}
