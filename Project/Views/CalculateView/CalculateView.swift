//
//  CalculateView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import SwiftUI
import Foundation
import RxSwift

@available(iOS 17.0, *)
struct CalculateView: View {
    
    @State var allBrawlers: [BrawlerDetail] = []
    @State var clicked = false
    @State var isLoading: Bool = false
    @State var error: Bool = false
    
    //total money icon size
    let iconSize: CGFloat = 20
    let fontSize: CGFloat = 20
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var calculateViewModel: RxCalculateViewModel
    
    let disposeBag = DisposeBag()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                
                let width = Constants.isPad() ? geo.size.width * 0.3 - 10 : geo.size.width * 0.9
                
                VStack(spacing : 20) {
                    calculateViewModel.DynamicStack(isPad: Constants.isPad()) {
                        
                        SearchBar(
                            clicked: $clicked,
                            searchBarViewModel: DIContainer.shared.makeSearchBarViewModel()
                        )
                        .environmentObject(calculateViewModel)
                        .environmentObject(appState)
                        .zIndex(1)
                        
                        MoneyBoxView()
                            .environmentObject(appState)
                    }
                    .frame(height: 110)

                    if calculateViewModel.isError {
                        VStack {
                            Spacer()
                            Text(calculateViewModel.errorMessage)
                                .fontDesign(.rounded)
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                            Text(NSLocalizedString("research", comment: ""))
                                .foregroundColor(.white)
                    
                            Spacer()
                        }
                        .frame(height: geo.size.height - 170)
                        
                    } else {
                        ScrollView {
                            // 역할군 순서 정의
                            let roleOrder = ["tanker", "assassin", "supporter", "controller", "damageDealer", "marksmen", "thrower"]

                            ForEach(roleOrder, id: \.self) { roleString in
                                let filtered = allBrawlers.filter { $0.role == roleString }

                                if !filtered.isEmpty {
                                    RoleBrawlerSection(
                                        roleString: roleString,
                                        filtered: filtered,
                                        width: width,
                                        clicked: clicked,
                                        isLoading: $isLoading
                                    )
                                    .environmentObject(appState)
                                }
                            }
                        }
                    }
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }//geo
            .ignoresSafeArea(.keyboard)
            .background(Color.backgroundColor)
            .onAppear {
                calculateViewModel.brawlersSubject
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { brawlers in
                        self.allBrawlers = brawlers
                        // 총합 계산
                        self.updateTotalCounts()
                    })
                    .disposed(by: disposeBag)

                calculateViewModel.isLoadingSubject
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { value in
                        self.isLoading = value
                    })
                    .disposed(by: disposeBag)


            }
        }
    }

    // 모든 브롤러의 총합 계산
    private func updateTotalCounts() {
        // 초기화
        appState.totalCoin = 0
        appState.totalPP = 0
        appState.totalCredit = 0

        // 모든 브롤러 순회하며 합산
        for brawler in allBrawlers {
            appState.totalCoin += brawler.calculateRequiredCoins()
            appState.totalPP += brawler.calculateRequiredPP()
            appState.totalCredit += brawler.calculateRequiredCredit()
        }
        }
    }



struct RoleBrawlerSection: View {
    let roleString: String
    let filtered: [BrawlerDetail]
    let width: CGFloat
    let clicked: Bool
    @Binding var isLoading: Bool

    @EnvironmentObject var appState: AppState
    let vm = ClassesTitleViewModel()
    let diContainer = DIContainer.shared

    // roleString을 Role enum으로 변환
    private var role: Role? {
        switch roleString {
        case "tanker": return .tanker
        case "assassin": return .assassin
        case "supporter": return .supporter
        case "controller": return .controller
        case "damageDealer": return .damageDealer
        case "marksmen": return .marksmen
        case "thrower": return .thrower
        default: return nil
        }
    }

    var body: some View {
        if !isLoading && clicked, let role = role {
            ClassesTitleView(
                imageName: vm.getImageName(role: role),
                title: vm.getClassTitle(role: role)
            )
            .padding(.top, 7)
        }

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if clicked {
                    if isLoading {
                        BrawlerEmptyView(width: width)
                    } else {
                        ForEach(filtered, id: \.id) { brawler in
                            BrawlerView(
                                width: width,
                                brawlerDetail: brawler,
                                viewModel: diContainer.makeBrawlersViewModel()
                            )
                            .environmentObject(appState)
                        }
                    }
                }
            }
            .scrollTargetLayout()
            .frame(height: 330)
        }
        .frame(height: 340)
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.1 / 2)
    }
}

