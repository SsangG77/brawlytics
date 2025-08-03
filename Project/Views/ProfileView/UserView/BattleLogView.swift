//
//  BattleLogView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/23/25.
//

import SwiftUI
import RxSwift
import Alamofire

struct BattleLogView: View {
    
    @ObservedObject var vm: BattleLogViewModel
    
    init(vm: BattleLogViewModel) {
        self.vm = vm
    }
    
    
    var body: some View {
        ZStack {
            Color.backgroundColor // 배경 뷰 (예: 색상)
                .ignoresSafeArea() // 화면 전체로 확장
            
            // 스켈레톤 뷰
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(0..<5) { _ in // 5개의 스켈레톤 뷰 표시
                        SingleBattleLogViewSkeleton()
                    }
                }
            }
            .opacity(vm.isLoading ? 1 : 0) // 로딩 중일 때 스켈레톤 표시, 로딩 완료 시 사라짐
            .animation(.easeOut(duration: 0.3), value: vm.isLoading) // 스켈레톤 페이드 아웃 애니메이션

            // 실제 콘텐츠 뷰
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(vm.battleLog) { log in
                        SingleBattleLogView(log: log, vm: vm)
                    }
                }
            }
            .opacity(vm.isLoading ? 0 : 1) // 로딩 중일 때 숨김, 로딩 완료 시 나타남
            .animation(.easeIn(duration: 0.5), value: vm.isLoading) // 실제 콘텐츠 페이드 인 애니메이션
            
        }
        .navigationTitle("Battle Logs")
        .navigationBarTitleDisplayMode(.large) // 선택 사항
        .onAppear {
            vm.fetchBattleLog()
        }
    }
}




#Preview {
    BattleLogView(
        vm: RxDIContainer.shared.makeBattleLogViewModel()
    )
}
