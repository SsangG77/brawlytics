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

    //viewModel
    @ObservedObject var viewModel:BrawlersViewModel

    // 계산된 값들
    private var ppCount: Int {
        brawlerDetail.calculateRequiredPP()
    }

    private var coinCount: Int {
        brawlerDetail.calculateRequiredCoins()
    }

    private var creditCount: Int {
        brawlerDetail.calculateRequiredCredit()
    }

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

