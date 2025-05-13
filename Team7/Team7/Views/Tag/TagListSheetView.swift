//
//  TagListSheetView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/12/25.
//

import SwiftUI
import SwiftData

var dummyWord = Word(wordName: "옵셔널", wordDefinition: "값이 있을 수도, 없을 수도 있는 타입.", tag: "test")

struct TagListSheetView: View {
    @Environment(\.modelContext) var context
    
    @State var tags: [Tag] = []
    
    @Binding var isTagSheetOpen: Bool
    @State var isSameTagNameExisting = false
    
    @State private var tagName = ""
    @State var selectedTag: Tag? // @경언님: 태그 선택 후 저장을 눌러 Word 값을 업데이트하실 때 쓰실 수 있게 만들어놓은 변수
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    SectionTitle(title: "태그 목록")
                    
                    List {
                        ForEach($tags) { tag in
                            Button {
                                selectedTag = tag.wrappedValue // @경언님: 여기서 selectedTag 가 유저가 선택한 이름으로 업데이트됨
                                isTagSheetOpen = false
                            } label: {
                                TagView(tag: tag.wrappedValue)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
                
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
                                .foregroundStyle(.customPrimary)
                        }
                        .disabled(tagName.isEmpty)
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button {
                        isTagSheetOpen = false
                    } label: {
                        Text("닫기")
                            .foregroundStyle(.customPrimary)
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
        let fetchDescriptor = FetchDescriptor<Tag>(
            sortBy: [ .init(\.name) ]
        )
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
