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

enum TagColors: String, CaseIterable {
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
    TagContainerView()
}
