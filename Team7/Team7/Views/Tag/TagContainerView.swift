//
//  TagContainerView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/12/25.
//

import SwiftUI
import SwiftData

// 태그에 대한 분기 처리를 하기 위한 컨테이너 뷰로,
// 태그 선택 시트를 열기 위한 버튼인지 or 단순히 태그를 보여주기 위한 라벨인지 결정
struct TagContainerView: View {
    @Environment(\.modelContext) var context
    
    @State var tag: String = "" // 상태값 -> 태그 이름

    @State var isTagSheetOpen = false
    @State var isButtonType = false // 태그 선택 시트를 열기 위한 버튼일 경우 true
    
    var body: some View {
        VStack {
            if isButtonType {
                Button {
                    isTagSheetOpen = true
                } label: {
                    TagView(
                        tag: Tag(name: tag), // String 을 Tag 타입에 담아 TagView 로 전달
                        isEditable: true
                    )
                }
                .sheet(isPresented: $isTagSheetOpen, content: {
                    TagListSheetView(isTagSheetOpen: $isTagSheetOpen, selectedTagName: $tag)
                        .presentationDetents([.medium])
                })
            } else {
                TagView(tag: Tag(name: tag)) // String 을 Tag 타입에 담아 TagView 로 전달
            }
        }
    }
}

extension TagContainerView {
}

// 태그가 생성될 시 색상이 랜덤으로 선택되게 하기 위해 색상들을 모아놓은 enum
enum TagColors: String, CaseIterable { // random 메서드를 사용해야 하므로 CaseIterable 프로토콜 준수
    case red, orange, yellow, green, blue, indigo, purple
    
    var hex: String {
        switch self {
        case .red: return "ffadad"
        case .orange: return "ffd6a5"
        case .yellow: return "f8ef8b"
        case .green: return "caffbf"
        case .blue: return "9bf6ff"
        case .indigo: return "a0c4ff"
        case .purple: return "bdb2ff"
        }
    }
}

#Preview {
    TagContainerView(tag: "비동기")
}
