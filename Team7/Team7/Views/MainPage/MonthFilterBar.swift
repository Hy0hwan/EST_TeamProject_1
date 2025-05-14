//
//  MonthFilterBar.swift
//  Team7
//
//  Created by 이유정 on 5/14/25.
//

import SwiftUI

struct MonthFilterBar: View {
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button(action: {
                    moveMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding(.horizontal)
                }

                Text("\(selectedYear)년 \(selectedMonth)월")
                    .font(.title3)
                    .padding(.vertical, 6)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.gray.opacity(0.15))
                    )

                Button(action: {
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    private func moveMonth(by value: Int) {
        let dateComponents = DateComponents(year: selectedYear, month: selectedMonth)
        let calendar = Calendar.current
        if let currentDate = calendar.date(from: dateComponents),
           let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            selectedYear = calendar.component(.year, from: newDate)
            selectedMonth = calendar.component(.month, from: newDate)
        }

    }
}

#Preview {
    MonthFilterBar()
}
