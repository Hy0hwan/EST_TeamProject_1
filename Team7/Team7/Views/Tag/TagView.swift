//
//  TagView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/13/25.
//

import SwiftUI

struct TagView: View {
    @State var tag: Tag?
    
    @State var isEditable: Bool = false
    
    var body: some View {
        if isEditable {
            if tag != nil {
                HStack(alignment: .center, spacing: 4) {
                    Text(tag!.name)
                    
                    Image(systemName: "arrow.up.right")
                        .imageScale(.small)
                        .foregroundStyle(.foreground.opacity(0.4))
                }
                .font(.footnote)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(Color(hexString: TagColors(rawValue: tag!.tagColor)?.hex ?? "000000", opacity: 0.5))
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .foregroundStyle(.foreground.opacity(0.8))
            } else {
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
        } else {
            if tag != nil {
                Text(tag!.name)
                    .font(.footnote)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color(hexString: TagColors(rawValue: tag!.tagColor)?.hex ?? "000000", opacity: 0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .foregroundStyle(.foreground.opacity(0.8))
                    .onAppear {
                        
                    }
            }
        }
    }
}

#Preview {
    TagContainerView(isButtonType: true)
}
