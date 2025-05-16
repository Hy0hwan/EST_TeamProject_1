//
//  TagView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/13/25.
//

import SwiftUI

// 태그의 모양을 정의하는 뷰
struct TagView: View {
    @State var tag: Tag? // 태그가 지정되지 않은 단어도 있을 수 있으므로 옵셔널로 선언
    
    @State var isEditable: Bool = false // 태그 시트를 여는 버튼인지 또는 단순 디스플레이용 라벨인지, 분기를 처리하기 위한 변수
    
    var body: some View {
        if isEditable { // 버튼 타입일 경우
            if tag != nil { // 태그가 비어있지 않을 경우
                HStack(alignment: .center, spacing: 4) {
                    Text(tag!.name) // 상단에서 옵셔널 언래핑을 마친 상태이므로 강제 언래핑
                    
                    Image(systemName: "arrow.up.right")
                        .imageScale(.small)
                        .foregroundStyle(.foreground.opacity(0.4))
                }
                .font(.footnote)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(
                    Color(
                        hexString: TagColors(rawValue: tag!.tagColor)?.hex ?? "000000", // Color 익스텐션 사용
                        opacity: 0.5
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .foregroundStyle(.foreground.opacity(0.8))
            } else { // 태그가 비어있을 경우
                HStack(alignment: .center, spacing: 4) {
                    Text("태그를 선택하세요")
                    
                    Image(systemName: "arrow.up.right")
                        .imageScale(.small)
                        .foregroundStyle(.foreground.opacity(0.4))
                }
                .font(.footnote)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .foregroundStyle(.foreground.opacity(0.8))
            }
        } else { // 버튼 타입이 아닐 경우
            if tag != nil {
                Text(tag!.name)
                    .font(.footnote)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Color(
                            hexString: TagColors(rawValue: tag!.tagColor)?.hex ?? "000000",
                            opacity: 0.5
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.foreground.opacity(0.8))
                    .onAppear {
                        
                    }
            }
        }
    }
}

#Preview {
    TagContainerView(tag: "비동기", isButtonType: true) 
}
