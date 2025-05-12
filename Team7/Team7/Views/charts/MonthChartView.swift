//
//  MonthChartView.swift
//  Team7
//
//  Created by 김효환 on 5/12/25.
//

import SwiftUI
import Charts

struct MonthData {
    var monthName: String
    var count: Int
}

extension MonthData {
    static func sampleData() -> [MonthData] {
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

struct MonthChartView: View {
    let stats = MonthData.sampleData()
    
    var body: some View {
        Chart(stats, id: \.monthName) { stat in
            BarMark(
                x: .value("Count", stat.count),
                y: .value("Month", stat.monthName)
            )
            
//            PointMark(
//                x: .value("Month", stat.monthName),
//                y: .value("Count", stat.count)
//            )
            
            //툴팁 설정
            .annotation(position: .overlay) {
                Text("\(stat.count)개")
                    .font(.caption)
                    .foregroundColor(.black)
            }
            
        }
        .frame(height: 500)
    }
}

#Preview {
    MonthChartView()
}
