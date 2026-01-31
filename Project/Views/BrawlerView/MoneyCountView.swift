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
        // 버피: UI 상태와 원본 상태가 다를 때 반영
        if !brawlerDetail.gadgetBuff.name.isEmpty {
            if gadgetBuffOwned && !brawlerDetail.gadgetBuff.owned {
                pp -= 2000
            } else if !gadgetBuffOwned && brawlerDetail.gadgetBuff.owned {
                pp += 2000
            }
        }
        if !brawlerDetail.starPowerBuff.name.isEmpty {
            if starPowerBuffOwned && !brawlerDetail.starPowerBuff.owned {
                pp -= 2000
            } else if !starPowerBuffOwned && brawlerDetail.starPowerBuff.owned {
                pp += 2000
            }
        }
        if !brawlerDetail.hyperchargeBuff.name.isEmpty {
            if hyperchargeBuffOwned && !brawlerDetail.hyperchargeBuff.owned {
                pp -= 2000
            } else if !hyperchargeBuffOwned && brawlerDetail.hyperchargeBuff.owned {
                pp += 2000
            }
        }
        return max(0, pp)
    }

    private var coinCount: Int {
        var coins = brawlerDetail.calculateRequiredCoins()
        print("=== [\(brawlerDetail.name)] coinCount 계산 ===")
        print("calculateRequiredCoins: \(coins)")
        print("hyperchargeOwned: \(hyperchargeOwned), hypercharge.name: \(brawlerDetail.hypercharge.name)")
        print("gadgetBuffOwned: \(gadgetBuffOwned), name: \(brawlerDetail.gadgetBuff.name)")
        print("starPowerBuffOwned: \(starPowerBuffOwned), name: \(brawlerDetail.starPowerBuff.name)")
        print("hyperchargeBuffOwned: \(hyperchargeBuffOwned), name: \(brawlerDetail.hyperchargeBuff.name)")

        // 하이퍼차지: UI 상태와 원본 상태가 다를 때 반영
        if !brawlerDetail.hypercharge.name.isEmpty {
            if hyperchargeOwned && !brawlerDetail.hypercharge.owned {
                // 원래 미소유 → 소유로 변경: 차감
                coins -= 5000
            } else if !hyperchargeOwned && brawlerDetail.hypercharge.owned {
                // 원래 소유 → 미소유로 변경: 추가
                coins += 5000
            }
        }
        // 버피: UI 상태와 원본 상태가 다를 때 반영
        if !brawlerDetail.gadgetBuff.name.isEmpty {
            if gadgetBuffOwned && !brawlerDetail.gadgetBuff.owned {
                coins -= 1000
            } else if !gadgetBuffOwned && brawlerDetail.gadgetBuff.owned {
                coins += 1000
            }
        }
        if !brawlerDetail.starPowerBuff.name.isEmpty {
            if starPowerBuffOwned && !brawlerDetail.starPowerBuff.owned {
                coins -= 1000
            } else if !starPowerBuffOwned && brawlerDetail.starPowerBuff.owned {
                coins += 1000
            }
        }
        if !brawlerDetail.hyperchargeBuff.name.isEmpty {
            if hyperchargeBuffOwned && !brawlerDetail.hyperchargeBuff.owned {
                coins -= 1000
            } else if !hyperchargeBuffOwned && brawlerDetail.hyperchargeBuff.owned {
                coins += 1000
            }
        }
        print("최종 coinCount: \(coins)")
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

                let coin = coinCount
                Text(String(coin))
                    .font(.title2)
                    .foregroundColor(Color(hexString: "E0E0E0"))
                    .onAppear {
                        print("UI에 표시되는 coin 값: \(coin), 브롤러: \(brawlerDetail.name)")
                    }
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

