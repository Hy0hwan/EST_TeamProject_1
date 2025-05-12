//
//  TagListSheetView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/12/25.
//

import SwiftUI

struct TagListSheetView: View {
    @Binding var isTagSheetOpen: Bool
    
    @State var tagName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 20) {
                    TextField("태그 이름을 입력해서 태그를 생성하세요.", text: $tagName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        
                    } label: {
                        Text("저장하기")
                    }
                    
                }
                .toolbar {
                    Button {
                        isTagSheetOpen = false
                    } label: {
                        Text("닫기")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    TagDisplayView(selectedTag: .constant(Tag(name: "문법")))
        .sheet(isPresented: .constant(true)) {
            TagListSheetView(isTagSheetOpen: .constant(true))
                .presentationDetents([.medium])
        }
}
