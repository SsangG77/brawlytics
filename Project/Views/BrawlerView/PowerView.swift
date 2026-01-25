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

    // 부모에서 전달받는 소유 상태 (실시간 UI 업데이트용)
    @Binding var hyperchargeOwned: Bool
    @Binding var gadgetBuffOwned: Bool
    @Binding var starPowerBuffOwned: Bool
    @Binding var hyperchargeBuffOwned: Bool

    //viewModel
    let viewModel:BrawlersViewModel

    //EnvironmentObject
    @EnvironmentObject var calculateViewModel: RxCalculateViewModel
    @EnvironmentObject var appState: AppState

    init(
        parentWidth: CGFloat,
        brawlerDetail: Binding<BrawlerDetail>,
        viewModel: BrawlersViewModel,
        hyperchargeOwned: Binding<Bool>,
        gadgetBuffOwned: Binding<Bool>,
        starPowerBuffOwned: Binding<Bool>,
        hyperchargeBuffOwned: Binding<Bool>
    ) {
        self.parentWidth = parentWidth
        self._brawlerDetail = brawlerDetail
        self.viewModel = viewModel
        self._hyperchargeOwned = hyperchargeOwned
        self._gadgetBuffOwned = gadgetBuffOwned
        self._starPowerBuffOwned = starPowerBuffOwned
        self._hyperchargeBuffOwned = hyperchargeBuffOwned
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
                        // 재화 업데이트 (하이퍼차지: 5000 코인)
                        appState.totalCoin += hyperchargeOwned ? -5000 : 5000
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
                        // 재화 업데이트 (버피: 1000 코인, 2000 PP)
                        appState.totalCoin += gadgetBuffOwned ? -1000 : 1000
                        appState.totalPP += gadgetBuffOwned ? -2000 : 2000
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
                        // 재화 업데이트 (버피: 1000 코인, 2000 PP)
                        appState.totalCoin += starPowerBuffOwned ? -1000 : 1000
                        appState.totalPP += starPowerBuffOwned ? -2000 : 2000
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
                        // 재화 업데이트 (버피: 1000 코인, 2000 PP)
                        appState.totalCoin += hyperchargeBuffOwned ? -1000 : 1000
                        appState.totalPP += hyperchargeBuffOwned ? -2000 : 2000
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
            }
        }
        .frame(width: parentWidth - 25)
        .padding(.vertical, 8)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)

    }
}
