//
//  TagDisplayView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/12/25.
//

import SwiftUI

struct TagDisplayView: View {
    @State var isTagSheetOpen = false
    @Binding var selectedTag: Tag
    
    var body: some View {
        VStack {
            Button {
                isTagSheetOpen = true
            } label: {
                HStack(alignment: .center, spacing: 4) {
                    Text(selectedTag.name)
                    
                    Image(systemName: "arrow.up.right")
                        .imageScale(.small)
                        .foregroundStyle(.foreground.opacity(0.4))
                }
                .font(.footnote)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(.yellow.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .foregroundStyle(.foreground.opacity(0.8))
            }
            .sheet(isPresented: $isTagSheetOpen, content: {
                TagListSheetView(isTagSheetOpen: $isTagSheetOpen)
                    .presentationDetents([.medium])
            })
        }
    }
}

enum TagColors: String {
    case red, orange, yellow, green, blue, indigo, purple
    
    var color: Color {
            switch self {
            case .red: return .red
            case .orange: return .orange
            case .yellow: return .yellow
            case .green: return .green
            case .blue: return .blue
            case .indigo: return .indigo
            case .purple: return .purple
            }
        }
}

#Preview {
    TagDisplayView(selectedTag: .constant(Tag(name: "문법")))
}
