//
//  MoneyCountView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import SwiftUI


struct MoneyCountView: View {

    @EnvironmentObject var appState: AppState
    @State var imageSize : CGFloat = 33

    //Binding
    var parentWidth: CGFloat
    @Binding var brawlerDetail: BrawlerDetail

    // 하이퍼차지/버피 소유 상태 (실시간 UI 업데이트용)
    @Binding var hyperchargeOwned: Bool
    @Binding var gadgetBuffOwned: Bool
    @Binding var starPowerBuffOwned: Bool
    @Binding var hyperchargeBuffOwned: Bool

    //viewModel
    @ObservedObject var viewModel:BrawlersViewModel

    // 계산된 값들 (하이퍼차지/버피 상태 반영)
    private var ppCount: Int {
        var pp = brawlerDetail.calculateRequiredPP()
        // 버피 소유 시 각각 2000 PP 차감
        if gadgetBuffOwned && !brawlerDetail.gadgetBuff.name.isEmpty { pp -= 2000 }
        if starPowerBuffOwned && !brawlerDetail.starPowerBuff.name.isEmpty { pp -= 2000 }
        if hyperchargeBuffOwned && !brawlerDetail.hyperchargeBuff.name.isEmpty { pp -= 2000 }
        return max(0, pp)
    }

    private var coinCount: Int {
        var coins = brawlerDetail.calculateRequiredCoins()
        // 하이퍼차지 소유 시 5000 코인 차감
        if hyperchargeOwned && !brawlerDetail.hypercharge.name.isEmpty { coins -= 5000 }
        // 버피 소유 시 각각 1000 코인 차감
        if gadgetBuffOwned && !brawlerDetail.gadgetBuff.name.isEmpty { coins -= 1000 }
        if starPowerBuffOwned && !brawlerDetail.starPowerBuff.name.isEmpty { coins -= 1000 }
        if hyperchargeBuffOwned && !brawlerDetail.hyperchargeBuff.name.isEmpty { coins -= 1000 }
        return max(0, coins)
    }

    private var creditCount: Int {
        brawlerDetail.calculateRequiredCredit()
    }

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
        HStack {
            Spacer()
            
            HStack {
                Image("pp")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(ppCount))
                    .font(.title2)
                    .foregroundColor(Color(hexString: "E0E0E0"))
            }
            Spacer()
            
            HStack {
                Image("coin")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(coinCount))
                    .font(.title2)
                    .foregroundColor(Color(hexString: "E0E0E0"))
            }
            Spacer()
            
            HStack {
                Image("credit")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(creditCount))
                    .font(.title2)
                    .foregroundColor(Color(hexString: "E0E0E0"))
            }
            Spacer()
            
        }
        .frame(width: parentWidth)
        .padding(.bottom, 4)
    }
}

