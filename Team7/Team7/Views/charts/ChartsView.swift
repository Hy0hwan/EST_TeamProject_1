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

struct MonthsData {
    var monthName: String
    var count: Int
}


struct ChartsView: View {
    @State private var selectedChart: ChartType = .month
    @Query var tags: [Tag]
    
    var monthData: [MonthsData] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: tags) { a in
            calendar.component(.month, from: a.createdAt) // 1~12월 숫자
            
        }
        
        return (1...12).map { monthNumber in
            let count = grouped[monthNumber]?.count ?? 0
            return MonthsData(monthName: "\(monthNumber)월", count: count)
        }
    }

    
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
                MonthChartView(data: monthData)
//                    .onAppear {
//                        print("월별 데이터 : \(monthData)")
//                    }
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
