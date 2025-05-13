//
//  TagChartView.swift
//  Team7
//
//  Created by 김효환 on 5/12/25.
//

import SwiftUI
import Charts

struct TagChartView: View {
    var data: [TagData]
    
    var body: some View {
        Chart(data, id: \.tagName) { element in
            SectorMark(
                angle: .value("사용 비율", element.count),
                innerRadius: .ratio(0.618),
                outerRadius: .inset(10),
                angularInset: 1.5
            )
            .cornerRadius(8)
            .foregroundStyle(by: .value("태그 이름", element.tagName))
        }

        .chartBackground { chartProxy in
            GeometryReader { geometry in
                if let anchor = chartProxy.plotFrame {
                    let frame = geometry[anchor]
                    VStack {
                        Text("전체 태그 수")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text("\(data.map(\.count).reduce(0, +))")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            }
        }
    }
}

#Preview {
    TagChartView(data: TagData.data())
}
