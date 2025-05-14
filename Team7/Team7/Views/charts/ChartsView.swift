//
//  ChartsView.swift
//  Team7
//
//  Created by 김효환 on 5/12/25.
//

import SwiftUI
import SwiftData

enum ChartType {
    case month
    case tag
}

struct TagData {
    var tagName: String
    var count: Int
}

extension TagData {
    
    static func monthData() -> [MonthData] {
        [
            MonthData(monthName: "1월", count: 4),
            MonthData(monthName: "2월", count: 6),
            MonthData(monthName: "3월", count: 9),
            MonthData(monthName: "4월", count: 3),
            MonthData(monthName: "5월", count: 4),
            MonthData(monthName: "6월", count: 6),
            MonthData(monthName: "7월", count: 9),
            MonthData(monthName: "8월", count: 3),
            MonthData(monthName: "9월", count: 4),
            MonthData(monthName: "10월", count: 6),
            MonthData(monthName: "11월", count: 9),
            MonthData(monthName: "12월", count: 3),
        ]
    }
}

struct ChartsView: View {
    @State private var selectedChart: ChartType = .month
    @Query var tags: [Tag]
    
    var tagData: [TagData] {
        Dictionary(grouping: tags, by: { a in a.name })
            .map { (key, value) in
                TagData(tagName: key, count: value.count)
            }
    }

    var body: some View {
        VStack {
            Picker("차트 타입", selection: $selectedChart) {
                Text("월별").tag(ChartType.month)
                Text("태그별").tag(ChartType.tag)
            }
            .pickerStyle(.segmented)
            .padding()
            
            
            if selectedChart == .month {
                MonthChartView(data: TagData.monthData())
            } else {
                TagChartView(data: tagData)
                    .onAppear{
                        print("tagData 확인 : \(tagData)")
                    } // console.log 같이 확인방법 .onAppear는 뷰가 랜더링될때 실행가능하다.
            }
        
            
            
            Spacer()
        }
        .padding()
        
    }
    
}

#Preview {
    ChartsView()
}
