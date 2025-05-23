//
//  BrawlerView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/4/24.
//

import SwiftUI

//MARK: - BrawlerView
//브롤러 한개당 정보 모음
@available(iOS 17.0, *)
struct BrawlerView: View {
    
    // size setting
    var totalHeight: CGFloat = 260
    var brawlerHeight: CGFloat = 210

    @State var brawler: Brawler?
    @State var opacity: Double = 1.0

    var width: CGFloat
    var brawlerStandard: BrawlerStandard

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    
    @StateObject var brawlersViewModel: BrawlersViewModel
    
    init(width: CGFloat, brawlerStandard: BrawlerStandard, viewModel: BrawlersViewModel) {
        self.width = width
        self.brawlerStandard = brawlerStandard
        _brawlersViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
        .onAppear {
            withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: true)) {
                opacity = opacity == 0.4 ? 0.8 : 0.4
            }
        }
        .onChange(of: calculateViewModel.brawlers) {
            withAnimation {
                brawler = calculateViewModel.findMyBrawler(brawlerName: brawlerStandard.name)
            }
        }
    }
    
    private var backgroundView: some View {
        Rectangle()
            .frame(width: width, height: totalHeight)
            .cornerRadius(20)
            .foregroundColor(Color(hexString: "576E90"))
            .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
    }

    private var contentView: some View {
        VStack(spacing: 0) {
            profileBlock
            moneyBlock
        }
        .frame(height: totalHeight)
    }

    private var profileBlock: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                BrawlerProfileView(parentWidth: width, brawler_st: brawlerStandard, brawler: $brawler)
                    .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))

                GearView(parentWidth: width, brawlerStandard: brawlerStandard, brawler: $brawler)
                    .environmentObject(brawlersViewModel)
                    .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))
            }

            PowerView(
                parentWidth: width,
                brawlerStandard: brawlerStandard,
                brawler: $brawler,
                viewModel: brawlersViewModel
            )
                .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))
        }
        .frame(width: width, height: brawlerHeight)
        .background(Color(hexString: "6D8CB9"))
        .cornerRadius(20)
        .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
        .overlay {
            if brawler?.name == "" {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(hexString: "000000", opacity: 0.7))
            }
        }
    }

    private var moneyBlock: some View {
        MoneyCountView(parentWidth: width, brawlerStandard: brawlerStandard, brawler: $brawler, viewModel: brawlersViewModel)
            .environmentObject(appState)
            .frame(height: totalHeight - brawlerHeight)
    }
}
