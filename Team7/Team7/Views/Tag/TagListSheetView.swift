//
//  TagListSheetView.swift
//  Team7
//
//  Created by Kitcat Seo on 5/12/25.
//

import SwiftUI
import SwiftData

// 등록된 태그를 표시하고, 선택 시 그에 따른 처리를 하고, 새로운 태그를 생성하기 위한 시트 뷰
struct TagListSheetView: View {
    @Environment(\.modelContext) var context
    
    @State var tags: [Tag] = []
    
    @Binding var isTagSheetOpen: Bool
    @Binding var selectedTagName: String // 태그 이름을 바인딩하기위해 새로 추가 : 효환

    @State var isSameTagNameExisting = false
    
    @State private var tagName = ""
    @State var selectedTag: Tag? // @경언님: 태그 선택 후 저장을 눌러 Word 값을 업데이트하실 때 쓰실 수 있게 만들어놓은 변수
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    // 등록된 태그를 표시하는 리스트 뷰
                    SectionTitle(title: "태그 목록")
                    
                    List {
                        ForEach($tags) { tag in
                            Button {
                                selectedTag = tag.wrappedValue // @경언님: 여기서 selectedTag 가 유저가 선택한 이름으로 업데이트됨
                                selectedTagName = tag.wrappedValue.name
                                isTagSheetOpen = false // 유저가 태그를 선택하면 시트가 닫히게 하기
                            } label: {
                                TagView(tag: tag.wrappedValue)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
                
                VStack(alignment: .leading) {
                    // 새로운 태그를 생성하는 텍스트 필드 뷰
                    SectionTitle(title: "새로운 태그 생성")
                    
                    HStack(spacing: 20) {
                        TextField("태그 이름", text: $tagName)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.leading)
                        
                        Button {
                            saveTag(context: context, tagName: tagName)
                            tagName = "" // 유저가 태그를 생성하면 시트가 닫히게 하기
                        } label: {
                            Text("저장하기")
                                .foregroundStyle(.customPrimary)
                        }
                        .disabled(tagName.isEmpty) // 텍스트 필드가 비어있을 경우 저장하기 버튼 비활성화
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
            .alert("태그 저장 실패", isPresented: $isSameTagNameExisting) { // 태그 이름 중복 체크하기
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
    // 태그 리스트를 가져오기
    func loadTags() {
        let fetchDescriptor = FetchDescriptor<Tag>(
            sortBy: [ .init(\.name) ]
        )
        if let fetchedTags = try? context.fetch(fetchDescriptor) {
            self.tags = fetchedTags
        }
    }
    
    // 새로운 태그를 저장하기
    func saveTag(context: ModelContext, tagName: String) {
        print(#function, #line, tags.map({ $0.name }))
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
    
    
    
    
    // 태그를 삭제하기
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            context.delete(tags[index])
        }
    }
}

// 중복되는 섹션 타이틀 스타일을 컴포넌트화
struct SectionTitle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.footnote)
            .foregroundStyle(.gray)
    }
}

//#Preview {
//    TagListSheetView(isTagSheetOpen: $isShowingTagSheet, selectedTagName: $tag)
//}
