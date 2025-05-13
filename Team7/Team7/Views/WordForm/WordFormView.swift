//
//  WordFormView.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//
// // Create/Update 화면 (기본 입력 UI만 포함)

import SwiftUI

struct WordFormView: View {
    @State private var protocolword: String = ""
    @State private var tag: String = ""
    @State private var meaning: String = ""

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Button("취소") {}
                Spacer()
                Button("저장") {}
            }
            .padding(.horizontal)
            .padding(.top)

            Text("단어 작성")
                .font(.title2)
                .bold()
                .frame(height: 20)

            VStack(spacing: 20) {
                TextField("Protocol", text: $protocolword)
                    .padding(.horizontal, 12)
                    .frame(height: 45)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                TextField("태그", text: $tag)
                    .padding(.horizontal, 12)
                    .frame(height: 45)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                TextEditor(text: $meaning)
                    .frame(height: 200)
                    .padding(.top, 8)
                    .padding(.horizontal, 4)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5), lineWidth: 1))
            }
            .padding(.horizontal)

            Spacer()
        }
    }
}


#Preview {
    WordFormView()
}
