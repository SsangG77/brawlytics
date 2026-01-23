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

    // 즉시 UI 업데이트를 위한 로컬 상태
    @State private var hyperchargeOwned: Bool = false
    @State private var gadgetBuffOwned: Bool = false
    @State private var starPowerBuffOwned: Bool = false
    @State private var hyperchargeBuffOwned: Bool = false

    //Binding
    var parentWidth: CGFloat
    @Binding var brawlerDetail: BrawlerDetail

    //viewModel
    let viewModel:BrawlersViewModel

    //EnvironmentObject
    @EnvironmentObject var calculateViewModel: RxCalculateViewModel

    init(
        parentWidth: CGFloat,
        brawlerDetail: Binding<BrawlerDetail>,
        viewModel: BrawlersViewModel
    ) {
        self.parentWidth = parentWidth
        self._brawlerDetail = brawlerDetail
        self.viewModel = viewModel
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

                if !brawlerDetail.hypercharge.name.isEmpty {
                    Button(action: {
                        hyperchargeOwned.toggle()
                        // 서버에 저장
                        viewModel.toggleHypercharge(brawlerDetail.hypercharge.name, owned: hyperchargeOwned)
                    }) {
                        RemoteItemImage(
                            url: brawlerDetail.itemURL(for: brawlerDetail.hypercharge.image),
                            width: imageSize,
                            height: imageSize,
                            isOwned: hyperchargeOwned
                        )
                    }
                }

                if !brawlerDetail.gadgetBuff.name.isEmpty {
                    Button(action: {
                        gadgetBuffOwned.toggle()
                        // 서버에 저장
                        viewModel.toggleBuffie(brawlerDetail.gadgetBuff.name, type: "gadget", owned: gadgetBuffOwned)
                    }) {
                        RemoteItemImage(
                            url: brawlerDetail.itemURL(for: brawlerDetail.gadgetBuff.image),
                            width: imageSize,
                            height: imageSize,
                            isOwned: gadgetBuffOwned
                        )
                    }
                }

                if !brawlerDetail.starPowerBuff.name.isEmpty {
                    Button(action: {
                        starPowerBuffOwned.toggle()
                        // 서버에 저장
                        viewModel.toggleBuffie(brawlerDetail.starPowerBuff.name, type: "starPower", owned: starPowerBuffOwned)
                    }) {
                        RemoteItemImage(
                            url: brawlerDetail.itemURL(for: brawlerDetail.starPowerBuff.image),
                            width: imageSize,
                            height: imageSize,
                            isOwned: starPowerBuffOwned
                        )
                    }
                }

                if !brawlerDetail.hyperchargeBuff.name.isEmpty {
                    Button(action: {
                        hyperchargeBuffOwned.toggle()
                        // 서버에 저장
                        viewModel.toggleBuffie(brawlerDetail.hyperchargeBuff.name, type: "hypercharge", owned: hyperchargeBuffOwned)
                    }) {
                        RemoteItemImage(
                            url: brawlerDetail.itemURL(for: brawlerDetail.hyperchargeBuff.image),
                            width: imageSize,
                            height: imageSize,
                            isOwned: hyperchargeBuffOwned
                        )
                    }
                }

                // 버피가 하나도 없을 때만 왼쪽 정렬
                if brawlerDetail.gadgetBuff.name.isEmpty &&
                   brawlerDetail.starPowerBuff.name.isEmpty &&
                   brawlerDetail.hyperchargeBuff.name.isEmpty {
                    Spacer()
                }
            }
        }
        .frame(width: parentWidth - 25)
        .padding(.vertical, 8)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)
        .onAppear {
            // 초기값 설정
            hyperchargeOwned = brawlerDetail.hypercharge.owned
            gadgetBuffOwned = brawlerDetail.gadgetBuff.owned
            starPowerBuffOwned = brawlerDetail.starPowerBuff.owned
            hyperchargeBuffOwned = brawlerDetail.hyperchargeBuff.owned
        }

    }
}
