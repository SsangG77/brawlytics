//
//  TierTrophyView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/25/25.
//

import SwiftUI

struct TierTrophyView: View {
    
    let rankImageName: String
    let current: Int
    let highest: Int
    
    init(rankImageName: String, current: Int, highest: Int) {
        self.rankImageName = rankImageName
        self.current = current
        self.highest = highest
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image("trophy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 43)
                    
                    
                    Text("\(current)")
                        .foregroundStyle(.white)
                        .font(.system(size: 27))
                        .fontWeight(.heavy)
                        .lineLimit(1) // 한 줄로 제한
                        .minimumScaleFactor(0.5) // 최소 50% 크기까지 축소
                }
                
                Text("Highest \(highest)")
                    .foregroundStyle(.white)
                    .font(.system(size: 14))
                    .opacity(0.7)
                    .padding(.leading, 6)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            Image(rankImageName)
                .resizable()
                .scaledToFit()
                .padding(14)
        }
    }
}

//#Preview {
//    TierTrophyView()
//}
