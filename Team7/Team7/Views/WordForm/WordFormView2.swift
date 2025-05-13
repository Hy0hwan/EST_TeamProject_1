//
//  WordFormView2.swift
//  Team7
//
//  Created by 김경언 on 5/12/25.
//

import SwiftUI

struct WordFormView2: View {
    //@State private var word2: String = ""
    // @State private var word3: String = ""
    
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button("삭제") {
                    
                }
                Spacer()
                
                Button("수정") {
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            
            Text("단어 상세")
                .font(.title2)
                .bold()
                .frame(height: 20)
            
            
            HStack(spacing: 4) {
                
                Text("단어 제목")
                    .font(.body)
                
                Spacer()
                
                Text("태그")
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 15)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            
            HStack {
                Text("2025. 05. 09")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.horizontal)
            
            
            
            HStack(spacing: 4) {
                Text("meaning")
                    .font(.body)
                
                Spacer()
                
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 15)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
           
            
        }
       
        Spacer()
        
    }
}

#Preview {
    WordFormView2()
}
