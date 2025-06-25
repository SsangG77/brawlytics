//
//  TrophyGraphView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/25/25.
//

import SwiftUI
import Charts

struct TrophyGraphView: View {
    
    let vm = OverlapCardViewModel(type: .graph)
    
    var body: some View {
        
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            
            OverlapCardView(vm: vm, frontView: {
                TierTrophyView(rankImageName: "tiermax", current: 930, highest: 1200)
                    .padding([.leading, .trailing], 10)
            }, backView: {
                ScrollView(.horizontal) {
                    LineChartView()
                        .frame(width: 60 * 10)
                }
                .contentMargins(15)
            })
        }
        .navigationTitle("Trophy Graph")
        
    }
}


struct TrophyGraphData: Identifiable {
    let id = UUID()
    let date: String
    let trophy: Int
}

struct LineChartView: View {
    let data: [TrophyGraphData] = [
        TrophyGraphData(date: "2/10", trophy: 850),
        TrophyGraphData(date: "2/11", trophy: 870),
        TrophyGraphData(date: "2/12", trophy: 900),
        TrophyGraphData(date: "2/13", trophy: 920),
        TrophyGraphData(date: "2/14", trophy: 950),
        TrophyGraphData(date: "2/15", trophy: 970),
        TrophyGraphData(date: "2/16", trophy: 990),
        TrophyGraphData(date: "2/17", trophy: 1990),
    ]
    
    var body: some View {
            Chart(data) {
                LineMark(
                    x: .value("Date", $0.date),
                    y: .value("Trophy", $0.trophy)
                )
                .symbol(Circle())
                .interpolationMethod(.catmullRom) // 곡선 처리
                
            }
            .chartXAxis {
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisGridLine()
                        .foregroundStyle(Color.white.opacity(0.3)) // X축 격자선 색상
                    AxisTick()
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisGridLine()
                        .foregroundStyle(Color.white.opacity(0.3)) // Y축 격자선 색상
                    AxisTick()
                    AxisValueLabel()
                }
            }
            .padding()
        }
}


#Preview {
    TrophyGraphView()
    Spacer()
}
