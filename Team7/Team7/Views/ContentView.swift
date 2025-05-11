//
//  ContentView.swift
//  Team7
//
//  Created by 김효환 on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // 최초에 더미 데이터를 주입하는 버튼입니다.
            // 주입하신 이후에는 사용할 필요가 없으니 주석 처리 해주세요.
            SeedDataInsertView()
        }
    }
}

#Preview {
    ContentView()
}
