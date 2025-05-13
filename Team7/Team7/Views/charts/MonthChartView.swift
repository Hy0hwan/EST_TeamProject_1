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


struct MonthChartView: View {
    var data: [MonthData]
    
    var body: some View {
        List {
            ForEach(data.reversed(), id: \.monthName) { item in
                HStack {
                    Text("2025년 \(item.monthName)")
                        .foregroundColor(.primary)
                    Spacer()

                    Button {
                        print("\(item.monthName) 월 클릭")
                    } label: {
                        HStack {
                            Text("\(item.count)개")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    
                }
                .padding(.vertical, 6)
            }
            .padding(.top, 8)
            
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    MonthChartView(data: [
        MonthData(monthName: "1월", count: 4),
        MonthData(monthName: "2월", count: 6),
        MonthData(monthName: "3월", count: 9),
        MonthData(monthName: "4월", count: 3),
        MonthData(monthName: "5월", count: 4)
    ])
}

