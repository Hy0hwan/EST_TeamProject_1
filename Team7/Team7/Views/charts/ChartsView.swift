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
    @EnvironmentObject var appState: AppState  
    @Query var tags: [Tag]
    
    var monthData: [MonthsData] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: tags) { a in
            calendar.component(.month, from: a.createdAt)
        }
        
        return (1...12).map { monthNumber in
            let count = grouped[monthNumber]?.count ?? 0
            return MonthsData(monthName: "\(monthNumber)월", count: count)
        }
    }

    var tagData: [TagData] {
        Dictionary(grouping: tags, by: { $0.name })
            .map { TagData(tagName: $0.key, count: $0.value.count) }
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
                MonthChartView(data: monthData) { selectedMonth in
                    appState.selectedMonthName = selectedMonth
                    appState.selectedTab = 0 // MainListView로 이동
                }
            } else {
                TagChartView(data: tagData)
                    .onAppear {
                        print("tagData 확인 : \(tagData)")
                    }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ChartsView()
}
