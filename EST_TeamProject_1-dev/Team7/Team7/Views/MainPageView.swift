//
//  MainPageView.swift
//  Team7
//
//  Created by 이유정 on 5/12/25.
//

import SwiftUI


struct MainPageView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // title
            Text("단어 목록")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 24)
            
            // search bar
            HStack {
                TextField("검색하실 단어를 입력하세요", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4)))
            .padding(.horizontal)
            
            // 필터링
            Text("필터링")
                .font(.subheadline)
                .padding(.leading)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("단어1")
                    Text("단어2")
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    MainPageView()
}

