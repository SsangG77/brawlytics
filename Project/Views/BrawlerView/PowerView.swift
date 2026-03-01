//
//  PowerView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import SwiftUI
import Kingfisher


struct PowerView: View {

    @State var imageSize: CGFloat = 50

    //Binding
    var parentWidth: CGFloat
    @Binding var brawlerDetail: BrawlerDetail

    init(
        parentWidth: CGFloat,
        brawlerDetail: Binding<BrawlerDetail>
    ) {
        self.parentWidth = parentWidth
        self._brawlerDetail = brawlerDetail
    }

    var body: some View {

        VStack(spacing: 8) {
            // 윗줄: 가젯 2개, 스타파워 2개
            HStack(spacing: 15) {

                if !brawlerDetail.firstGadget.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.firstGadget.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.firstGadget.owned
                    )
                }

                if !brawlerDetail.secondGadget.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.secondGadget.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.secondGadget.owned
                    )
                }

                if !brawlerDetail.firstStarPower.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.firstStarPower.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.firstStarPower.owned
                    )
                }

                if !brawlerDetail.secondStarPower.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.secondStarPower.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.secondStarPower.owned
                    )
                }
            }

            // 아랫줄: 하이퍼차지, 버피 3개
            HStack(spacing: 15) {

                // 하이퍼차지 (없으면 빈 공간)
                if !brawlerDetail.hypercharge.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.hypercharge.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.hypercharge.owned
                    )
                } else {
                    Color.clear.frame(width: imageSize, height: imageSize)
                }

                // 가젯 버피 (없으면 빈 공간)
                if !brawlerDetail.gadgetBuff.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.gadgetBuff.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.gadgetBuff.owned
                    )
                } else {
                    Color.clear.frame(width: imageSize, height: imageSize)
                }

                // 스타파워 버피 (없으면 빈 공간)
                if !brawlerDetail.starPowerBuff.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.starPowerBuff.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.starPowerBuff.owned
                    )
                } else {
                    Color.clear.frame(width: imageSize, height: imageSize)
                }

                // 하이퍼차지 버피 (없으면 빈 공간)
                if !brawlerDetail.hyperchargeBuff.name.isEmpty {
                    RemoteItemImage(
                        url: brawlerDetail.itemURL(for: brawlerDetail.hyperchargeBuff.image),
                        width: imageSize,
                        height: imageSize,
                        isOwned: brawlerDetail.hyperchargeBuff.owned
                    )
                } else {
                    Color.clear.frame(width: imageSize, height: imageSize)
                }
            }
        }
        .frame(width: parentWidth - 25)
        .padding(.vertical, 8)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)

    }
}
