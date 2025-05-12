//
//  TagListSheetView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/12/25.
//

import SwiftUI
import SwiftData

struct TagListSheetView: View {
    @Environment(\.modelContext) var context
    
    @State var tags: [Tag] = []
    
    @Binding var isTagSheetOpen: Bool
    @State var isSameTagNameExisting = false
    
    @State private var tagName = ""
    @State var selectedTag: Tag?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    SectionTitle(title: "새로운 태그 생성")
                    
                    HStack(spacing: 20) {
                        TextField("태그 이름", text: $tagName)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.leading)
                        
                        Button {
                            saveTag(context: context, tagName: tagName)
                            tagName = ""
                        } label: {
                            Text("저장하기")
                        }
                        .disabled(tagName.isEmpty)
                    }
                }
//                
                VStack(alignment: .leading) {
                    SectionTitle(title: "기존 태그 목록")
                    
                    List {
                        ForEach($tags) { tag in
                            Button {
                                print(tag)
                            } label: {
                                TagDisplayView(tag: tag, isEditable: false)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button {
                        isTagSheetOpen = false
                    } label: {
                        Text("닫기")
                    }
                }
            }
            .alert("태그 저장 실패", isPresented: $isSameTagNameExisting) {
                Button("확인") {
                    isSameTagNameExisting = false
                }
            } message: {
                Text("이미 등록된 태그입니다.")
            }
        }
        .onAppear {
            loadTags()
        }
    }
}

extension TagListSheetView {
    func loadTags() {
        let fetchDescriptor = FetchDescriptor<Tag>()
        if let fetchedTags = try? context.fetch(fetchDescriptor) {
            self.tags = fetchedTags
        }
    }
    
    func saveTag(context: ModelContext, tagName: String) {
        if tags.first(where: { $0.name == tagName }) != nil {
            isSameTagNameExisting = true
        } else {
            let newTag = Tag(name: tagName)
            context.insert(newTag)
            
            do {
                try context.save()
            } catch {
                print("Failed to save the data: \(error)")
            }
        }
        loadTags()
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            context.delete(tags[index])
        }
    }
}

struct SectionTitle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.footnote)
            .foregroundStyle(.gray)
    }
}

#Preview {
    TagListSheetView(isTagSheetOpen: .constant(false))
}
