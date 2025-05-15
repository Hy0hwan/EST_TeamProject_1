//
//  MonthChartView.swift
//  Team7
//
//  Created by 김효환 on 5/12/25.
//

import SwiftUI
import Charts





struct MonthChartView: View {
    var data: [MonthsData]
    var selectMonth: (String) -> Void
    var body: some View {
        List {
            ForEach(data.reversed(), id: \.monthName) { item in
                HStack {
                    Text("2025년 \(item.monthName)")
                    Spacer()
                    Button {
                        selectMonth("2025년 \(item.monthName)")
                    } label: {
                        Text("\(item.count)개")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 6)
            }
        }
        .listStyle(.plain)
    }
}

//#Preview {
//    MonthChartView(data: [
//        MonthData(monthName: "1월", count: 4),
//        MonthData(monthName: "2월", count: 6),
//        MonthData(monthName: "3월", count: 9),
//        MonthData(monthName: "4월", count: 3),
//        MonthData(monthName: "5월", count: 4)
//    ])
//}

