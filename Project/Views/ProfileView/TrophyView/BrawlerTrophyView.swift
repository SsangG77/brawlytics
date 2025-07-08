//
//  BrawlerTrophyView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/24/25.
//

import SwiftUI


// 각 브롤러 카드뷰
struct BrawlerTrophyView: View {
    
    // ViewModel
    let overlapCardVM: OverlapCardViewModel = OverlapCardViewModel(type: .brawler)
    let brawlerTrophyViewModel: BrawlerTrophyViewModel
    
    let brawlerTrophyModel : BrawlerTrophyModel
    
    
    init(brawlerTrophyModel: BrawlerTrophyModel, vm: BrawlerTrophyViewModel) {
        self.brawlerTrophyModel = brawlerTrophyModel
        self.brawlerTrophyViewModel = vm
    }
    
    var body: some View {
        OverlapCardView(vm: overlapCardVM, frontView: {
            HStack {
                Image(brawlerTrophyModel.name.uppercased())
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                Text(brawlerTrophyModel.name)
                    .fontWeight(.semibold)
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .padding(.trailing, 60)
            }
        }, backView: {
            HStack {
                TierTrophyView(
                    rankImageName: "rank\(brawlerTrophyModel.rank)",
                    current: brawlerTrophyModel.currentTrophy,
                    highest: brawlerTrophyModel.highestTrophy
                )
                
                Image(systemName: "chart.xyaxis.line")
                    .foregroundColor(.white)
            
                Image(systemName: "chevron.compact.forward")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                    .padding(.trailing, 12)
                
            }
        })
    }
}

//#Preview {
//    BrawlerTrophyView(brawlerTrophyModel: BrawlerTrophyModel(name: "kenji", currentTrophy: 1000, highestTrophy: 1000))
//    Spacer()
//}
