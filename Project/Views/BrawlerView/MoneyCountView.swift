//
//  MoneyCountView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import SwiftUI


struct MoneyCountView: View {
    
    @State var ppCount = -1
    @State var coinCount = -1
    @State var creditCount = -1
    @EnvironmentObject var appState: AppState
    
    @State var imageSize : CGFloat = 33
    
    //Binding
    var parentWidth: CGFloat
    var brawlerStandard: BrawlerStandard
    @Binding var brawler: Brawler?
    
    //viewModel
    @ObservedObject var viewModel:BrawlersViewModel
        
    init(
        parentWidth: CGFloat,
        brawlerStandard: BrawlerStandard,
        brawler: Binding<Brawler?>,
        viewModel: BrawlersViewModel
    ) {
        self.parentWidth = parentWidth
        self.brawlerStandard = brawlerStandard
        self._brawler = brawler
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
            }
            
            Spacer()
            
            HStack {
                Image("coin")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(coinCount))
                    .font(.title2)
            }
            
            Spacer()
            
            HStack {
                Image("credit")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(creditCount))
                    .font(.title2)
            }
            
            Spacer()
            
            
            
            
        }
        .frame(width: parentWidth)
        .padding(.bottom, 4)
        .onChange(of: brawler) { newValue in
            if newValue != nil {
                ppCount = viewModel.calculatePP(brawler: brawler, brawlerStandard: brawlerStandard)
                creditCount = viewModel.calculateCredit(brawler: brawler, brawlerStandard: brawlerStandard)
                coinCount = viewModel.calculateCoin(brawler: brawler, brawlerStandard: brawlerStandard)
//
                appState.totalPP += viewModel.calculatePP(brawler: brawler, brawlerStandard: brawlerStandard)
                appState.totalCredit += viewModel.calculateCredit(brawler: brawler, brawlerStandard: brawlerStandard)
                appState.totalCoin += viewModel.calculateCoin(brawler: brawler, brawlerStandard: brawlerStandard)
                
            }
            
        }
       
    }
}

