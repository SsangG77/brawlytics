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
    let brawlerTrophyViewModel = BrawlerTrophyViewModel()
    
    let brawlerTrophyModel : BrawlerTrophyModel
    
    
    init(brawlerTrophyModel: BrawlerTrophyModel) {
        self.brawlerTrophyModel = brawlerTrophyModel
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
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image("trophy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 43)
                            
                        
                        Text("\(brawlerTrophyModel.currentTrophy)")
                            .foregroundStyle(.white)
                            .font(.system(size: 27))
                            .fontWeight(.heavy)
                            .lineLimit(1) // 한 줄로 제한
                            .minimumScaleFactor(0.5) // 최소 50% 크기까지 축소
                            
                        
                    }
                    
                    Text("Highest \(brawlerTrophyModel.highestTrophy)")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .opacity(0.7)
                        .padding(.leading, 6)
                }
                .padding(.leading, 20)
                
                Spacer()
                
                Image(brawlerTrophyViewModel.getRank(for: brawlerTrophyModel.currentTrophy))
                    .resizable()
                    .scaledToFit()
                    .padding(14)
                    
                
                
            
                Image(systemName: "chevron.compact.forward")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                    .padding(.trailing, 12)
                
            }
        })
    }
}

#Preview {
    BrawlerTrophyView(brawlerTrophyModel: BrawlerTrophyModel(name: "kenji", currentTrophy: 1000, highestTrophy: 1000))
    Spacer()
}
