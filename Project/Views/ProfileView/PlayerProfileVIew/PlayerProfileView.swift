//
//  PlayerProfileView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI
import RxSwift
import Alamofire






//유저 정보 카드 뷰
struct PlayerProfileView: View {
    
    @ObservedObject var vm: PlayerProfileViewModel
    let classTitleVM = ClassesTitleViewModel()
    let brawlerTrophyVM = RxDIContainer.shared.makeBrawlerTrophyViewModel()
    
    init(vm: PlayerProfileViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()

                // 스켈레톤 뷰
                TotalSkeleton()
                .opacity(vm.isLoading ? 1 : 0) // 로딩 중일 때 스켈레톤 표시, 로딩 완료 시 사라짐
                .animation(.easeOut(duration: 0.3), value: vm.isLoading) // 스켈레톤 페이드 아웃 애니메이션

                // 실제 콘텐츠 뷰
                ScrollView {
                    VStack(alignment: .center, spacing: 24) {
                        userSection()
                        brawlerSection()
                    }
                    .padding()
                }
                .opacity(vm.isLoading ? 0 : 1) // 로딩 중일 때 숨김, 로딩 완료 시 나타남
                .animation(.easeIn(duration: 0.5), value: vm.isLoading) // 실제 콘텐츠 페이드 인 애니메이션
            }
            .onAppear {
                let savedPlayerTag = UserDefaults.standard.string(forKey: "playerTag") ?? "(없음)"
                print("PlayerProfileView onAppear - UserDefaults playerTag: \(savedPlayerTag)")
                vm.fetchUserProfile()
                vm.fetchBrawlersTrophy()
            }
        }
    }
    
    
    @ViewBuilder
    private func userSection() -> some View {
        if let user = vm.user {
            NavigationLink(destination: BattleLogView(
                vm: RxDIContainer.shared.makeBattleLogViewModel()
            )) {
                UserView(user: user)
            }
        } else {
            VStack {
                Spacer()
            if let savedPlayerTag = UserDefaults.standard.string(forKey: "playerTag") {
                Text("네트워크 에러입니다")
                    .foregroundColor(.white)
            } else {
                Text("설정에서 플레이어 태그를 입력해주세요")
                    .foregroundColor(.white)
            }
                Spacer()
            }
            
        }
    }

    @ViewBuilder
    private func brawlerSection() -> some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 16) {
                let grouped = vm.groupedBrawlers
                let order: [Role] = [.tanker, .assassin, .supporter, .controller, .damageDealer, .marksmen, .thrower]

                let sortedRoles = grouped.keys.sorted {
                    order.firstIndex(of: $0)! < order.firstIndex(of: $1)!
                }

                ForEach(Array(sortedRoles), id: \.self) { role in
                    brawlerSectionView(for: role, brawlers: grouped[role] ?? [])
                }
            }
            .padding(.vertical)
        }
    }

    @ViewBuilder
    private func brawlerSectionView(for role: Role, brawlers: [BrawlerTrophyModel]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ClassesTitleView(
                imageName: classTitleVM.getImageName(role: role),
                title: classTitleVM.getClassTitle(role: role)
            )
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(brawlers) { brawler in
                        NavigationLink(destination: TrophyGraphView(
                            brawlerTrophyModel: brawler,
                            vm: brawlerTrophyVM
                        )) {
                            BrawlerTrophyView(
                                brawlerTrophyModel: brawler,
                                vm: brawlerTrophyVM
                            )
                                .scrollTargetLayout()
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 210)
            .scrollTargetBehavior(.viewAligned)
        }
    }

}



#Preview {
    PlayerProfileView(
        vm: RxDIContainer.shared.makePlayerProfileViewModel()
    )
}
