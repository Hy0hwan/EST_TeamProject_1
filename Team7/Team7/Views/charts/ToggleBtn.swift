//
//  ToggleBtn.swift
//  Team7
//
//  Created by 김효환 on 5/13/25.
//

import SwiftUI

struct ToggleBtn: View {
    
    @Binding var onClickBtn: Bool
    @State var leftName: String
    @State var rightName : String
    
    
    var body: some View {
            ZStack{
                Capsule()
                    .fill(.blue)
                    .stroke(onClickBtn ? .gray : .black,lineWidth: 3)
                    .frame(width: 200,height: 50)
                HStack{
                    ZStack{
                        Capsule()
                            .fill(.yellow)
                            .frame(width: 93,height: 48)
                            .onTapGesture {
                                onClickBtn.toggle()
                            }
                            .offset(x: onClickBtn ? 107 : 0)
//                            .animation(.easeOut(duration: 0.5))
                            .animation(.easeOut(duration: 0.5), value: onClickBtn)

                        Text("\(leftName)")
                    }
                    ZStack{
                        Capsule()
                            .fill(.clear)
                            .frame(width: 98,height: 48)
                        Text("\(rightName)")
                    }
                }
            }
    }
}

#Preview {
    ToggleBtn(onClickBtn : .constant(false),leftName: "Light", rightName: "Dark")
}
