//
//  ChartsView.swift
//  Team7
//
//  Created by 김효환 on 5/12/25.
//

import SwiftUI

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
    
    
    static func tagData() -> [TagData] {
        [
            TagData(tagName: "CS", count: 10),
            TagData(tagName: "Swift", count: 10),
            TagData(tagName: "Java", count: 10),
            TagData(tagName: "기타", count: 20)
        ]
    }
}

struct ChartsView: View {
    @State private var selectedChart: ChartType = .month
    
    var body: some View {
        VStack {
            Picker("차트 타입", selection: $selectedChart) {
                Text("월별").tag(ChartType.month)
                Text("태그별").tag(ChartType.tag)
            }
            .pickerStyle(.segmented)
            .padding()
            
            
            // 조건부 랜더링
            if selectedChart == .month {
                MonthChartView(data: TagData.monthData())
            } else {
                TagChartView(data: TagData.tagData())
            }
            
            
            Spacer()
        }
        .padding()
        
    }
    
}

#Preview {
    ChartsView()
}
