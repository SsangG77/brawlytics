//
//  BrawlerView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/4/24.
//

import SwiftUI
import RxSwift

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
    
#warning("RX 방식 변경을 위한 테스트")
//    @EnvironmentObject var calculateViewModel: CalculateViewModel
    @EnvironmentObject var calculateViewModel: RxCalculateViewModel
    let disposeBag = DisposeBag()
    
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
             setupAnimation()
             subscribeToBrawlers()
         }
    }

    // MARK: - Private Methods
    private func setupAnimation() {
        withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: true)) {
            opacity = opacity == 0.4 ? 0.8 : 0.4
        }
    }
    
#warning("RX 방식 변경을 위한 테스트")
    private func subscribeToBrawlers() {
         calculateViewModel.brawlersSubject
             .observe(on: MainScheduler.instance)
             .subscribe(onNext: { _ in
                 updateBrawler()
             })
             .disposed(by: disposeBag)
     }

    private func updateBrawler() {
        withAnimation {
            brawler = calculateViewModel.findMyBrawler(brawlerName: brawlerStandard.name)
        }
    }


    
    private var backgroundView: some View {
        VStack{}
            .frame(width: width, height: totalHeight)
            .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, backgroundColor: .deepColor , radius: 20, corners: [.allCorners])
    }

    private var contentView: some View {
        VStack(spacing: 0) {
            profileBlock
            moneyBlock
        }
        .frame(height: totalHeight - 20)
    }

    private var profileBlock: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                profileSection
                gearSection
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
        .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, backgroundColor: Color.lightColor, radius: 20, corners: [.allCorners])
        .overlay {
            if brawler?.name == "" {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(hexString: "000000", opacity: 0.7))
            }
        }
    }

    private var profileSection: some View {
        BrawlerProfileView(
            parentWidth: width,
            brawler_st: brawlerStandard,
            brawler: $brawler
        )
        .modifier(BlinkingAnimationModifier(
            shouldShow: brawler == nil,
            opacity: opacity
        ))
    }

     private var gearSection: some View {
        GearView(
            parentWidth: width,
            brawlerStandard: brawlerStandard,
            brawler: $brawler
        )
        .environmentObject(brawlersViewModel)
        .modifier(BlinkingAnimationModifier(
            shouldShow: brawler == nil,
            opacity: opacity
        ))
    }

    private var moneyBlock: some View {
        MoneyCountView(parentWidth: width, brawlerStandard: brawlerStandard, brawler: $brawler, viewModel: brawlersViewModel)
            .environmentObject(appState)
            .frame(height: totalHeight - brawlerHeight)
    }
}
