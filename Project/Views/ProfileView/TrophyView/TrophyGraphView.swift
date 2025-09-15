//
//  TrophyGraphView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/25/25.
//

import SwiftUI
import Charts




struct TrophyGraphData: Identifiable, Decodable {
    var id = UUID()
    let date: String
    let trophy: Int

    private enum CodingKeys: String, CodingKey {
        case date, trophy
    }
}



struct TrophyGraphView: View {
    let overlayCardVM = OverlapCardViewModel(type: .graph)
    @ObservedObject var vm: BrawlerTrophyViewModel
    let brawlerTrophyModel : BrawlerTrophyModel
    
    init(brawlerTrophyModel: BrawlerTrophyModel, vm: BrawlerTrophyViewModel) {
        self.brawlerTrophyModel = brawlerTrophyModel
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            
            OverlapCardView(vm: overlayCardVM, frontView: {
                TierTrophyView(
                    rankImageName: "rank\(brawlerTrophyModel.rank)",
                    current: brawlerTrophyModel.currentTrophy,
                    highest: brawlerTrophyModel.highestTrophy
                )
                .padding([.leading, .trailing], 10)
            }, backView: {
                ScrollView(.horizontal) {
                    LineChartView(data: vm.trophyData)
                        .frame(width: 60 * CGFloat(vm.trophyData.count))
                }
                .contentMargins(15)
            })
        }
        .navigationTitle("Trophy Graph")
        .onAppear {
            vm.loadTrophyData(brawlerName: brawlerTrophyModel.name)
        }
    }
}


struct LineChartView: View {
    
    let data: [TrophyGraphData]
    
    init(data: [TrophyGraphData]) {
        self.data = data
    }
   
    
    var body: some View {
            Chart(data) {
                LineMark(
                    x: .value("Date", $0.date),
                    y: .value("Trophy", $0.trophy)
                )
                .symbol(Circle())
                .interpolationMethod(.catmullRom) // 곡선 처리
                .foregroundStyle(Color.backgroundColor)
                
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

//
//#Preview {
//    TrophyGraphView()
//}
