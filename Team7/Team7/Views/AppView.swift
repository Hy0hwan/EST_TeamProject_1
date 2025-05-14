//
//  AppView.swift
//  Team7
//
//  Created by 김효환 on 5/13/25.
//

import SwiftUI
import Foundation

class AppState: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var selectedMonthName: String? = nil
}

struct AppView: View {
    @StateObject var appState = AppState()
    @State var isSeedDataViewOpen = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    isSeedDataViewOpen = true
                } label: {
                    Label("시드 데이터 관리하기", systemImage: "drop.fill")
                        .font(.footnote)
                }

                Spacer()

                TagContainerView(tag: "문법", isButtonType: true)
            }
            .padding()
            .sheet(isPresented: $isSeedDataViewOpen) {
                SeedDataInsertView()
                    .presentationDetents([.medium])
            }

            // 탭 뷰
            TabView(selection: $appState.selectedTab) {
                MainListView(monthName: appState.selectedMonthName)
                    .tabItem {
                        Label("단어장", systemImage: "text.book.closed.fill")
                    }
                    .tag(0)
                
                ChartsView()
                    .tabItem {
                        Label("통계", systemImage: "chart.bar")
                    }
                    .tag(1)
            }
        }
        .environmentObject(appState)
    }
}

#Preview {
    AppView()
}
