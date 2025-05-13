//
//  AppView.swift
//  Team7
//
//  Created by 김효환 on 5/13/25.
//

import SwiftUI

struct AppView: View {
    @State var isSeedDataViewOpen = false
    
    var body: some View {
        // 태그 관리 화면으로 가는 진입점이 없어서 임시로 추가해 놓음!! 발표 준비할 때는 지우기!!!
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
