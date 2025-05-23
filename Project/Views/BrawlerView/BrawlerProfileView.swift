//
//  BrawlerProfileView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import SwiftUI

//MARK: - BrawlerProfileView
struct BrawlerProfileView: View {
    
    var parentWidth: CGFloat
//    @Binding var brawler_st: BrawlerStandard
    var brawler_st: BrawlerStandard
    @Binding var brawler: Brawler?
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            // 배경 이미지
            Image(brawler_st.name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (parentWidth - 35) * 0.3, height: (parentWidth - 35) * 0.3) // 이미지 크기 설정
                .clipped()
            
            // 레벨 표시를 위한 ZStack
            ZStack {
                Image("level")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text(String(brawler?.name ?? "" == "" ? 0 : brawler?.power ?? 0))
                    .foregroundColor(.white)
                    .fontWeight(.black)
            }
            .offset(x: 1, y: 0) // 이미지의 왼쪽 상단에 고정 위치 지정
        }
        .frame(width: (parentWidth - 35) * 0.3, height: (parentWidth - 35) * 0.3)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)
    }
}
