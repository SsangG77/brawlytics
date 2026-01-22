//
//  BrawlerProfileView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import SwiftUI
import Kingfisher

//MARK: - BrawlerProfileView
struct BrawlerProfileView: View {

    var parentWidth: CGFloat
    @Binding var brawlerDetail: BrawlerDetail

    var body: some View {

        ZStack(alignment: .bottomLeading) {
            // 배경 이미지
            RemoteBrawlerImage(
                url: brawlerDetail.brawlerImageURL,
                width: (parentWidth - 35) * 0.3,
                height: (parentWidth - 35) * 0.3
            )
            .aspectRatio(contentMode: .fill)
            .clipped()

            // 레벨 표시를 위한 ZStack
            ZStack {
                Image("level")
                    .resizable()
                    .frame(width: 40, height: 40)

                Text(String(brawlerDetail.owned == false ? 0 : brawlerDetail.power ?? 0))
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
