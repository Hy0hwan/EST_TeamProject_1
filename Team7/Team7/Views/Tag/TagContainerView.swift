//
//  TagContainerView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/12/25.
//

import SwiftUI
import SwiftData

struct TagContainerView: View {
    @Environment(\.modelContext) var context
    
    @State var isTagSheetOpen = false
    @State var isButtonType = false
    @State var tag: Tag?
    
    var body: some View {
        VStack {
            if isButtonType {
                Button {
                    isTagSheetOpen = true
                } label: {
                    TagView(tag: tag, isEditable: isButtonType)
                }
                .sheet(isPresented: $isTagSheetOpen, content: {
                    TagListSheetView(isTagSheetOpen: $isTagSheetOpen)
                        .presentationDetents([.medium])
                })
            } else {
                TagView(tag: tag, isEditable: isButtonType)
            }
        }
    }
}

extension TagContainerView {
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
    TagContainerView()
}
