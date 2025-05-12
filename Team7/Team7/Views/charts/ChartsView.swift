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

struct ChartsView: View {
    @State private var selectedChart: ChartType = .month

    var body: some View {
        VStack {
            HStack() {
                Button {
                    selectedChart = .month
                } label: {
                    Text("월별")
                        .padding()
                        .background(selectedChart == .month ? Color.black : Color.gray.opacity(0.3))
                        .foregroundColor(selectedChart == .month ? .white : .black)
                        .clipShape(Capsule())
                }

                Button {
                    selectedChart = .tag
                } label: {
                    Text("태그별")
                        .padding()
                        .background(selectedChart == .tag ? Color.black : Color.gray.opacity(0.3))
                        .foregroundColor(selectedChart == .tag ? .white : .black)
                        .clipShape(Capsule())
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .clipShape(Capsule())

            // 조건부 랜더링
            if selectedChart == .month {
                MonthChartView()
            } else {
                TagChartView()
            }

            Spacer()
        }
        .padding()
    }
       
}

#Preview {
    ChartsView()
}
