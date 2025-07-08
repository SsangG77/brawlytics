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



struct SingleBattleLogView: View {
    
    let overlapCardVM: OverlapCardViewModel
    let vm: BattleLogViewModel
    let log: BattleLogModel
    var type: CardType = .soloShowdown
    
    init(log: BattleLogModel, vm: BattleLogViewModel) {

        if log.result == "victory" {
            type = .win
        } else if log.result == "defeat" {
            type = .lose
        } else if log.mode == "soloShowdown" {
            type = .soloShowdown
        } else if log.mode == "duoShowdown" {
            type = .duoShowdown
        } else if log.mode == "trioShowdown" {
            type = .trioShowdown
        }
        
        self.overlapCardVM = OverlapCardViewModel(type: type)
        
        
        self.vm = vm
        self.log = log
    }
    
    
    var body: some View {
        OverlapCardView(vm: overlapCardVM, frontView: {
            logView
        }, backView: {
           header
        })
    }
    
    
    var header: some View {
        HStack(spacing: 0) {
            
            Image(vm.checkMode(mode: log.mode))
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(vm.getMapName(mapName:log.mapName))
                    .lineLimit(1) // 한 줄로 제한
                    .minimumScaleFactor(0.5) // 최소 50% 크기까지 축소
                    .font(.title3)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            
                Text(log.date)
                    .foregroundStyle(Color(hexString: "FFFFFF", opacity: 0.7))
                    .lineLimit(1) // 한 줄로 제한
                    .minimumScaleFactor(0.5) // 최소 50% 크기까지 축소
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
            }
            .padding(.leading, 15)
            
            Spacer()
            

            Text(overlapCardVM.type == .win ? "WIN" : overlapCardVM.type == .lose ? "LOSE" : "")
                .fontWeight(.bold)
                .font(.system(size: 37))
                .foregroundStyle(overlapCardVM.fontColor)
        }
        .padding(.horizontal, 25)
    }
    
    var logView: some View {
        
        Group {
            if overlapCardVM.isPad {
                HStack(spacing: 0) {
                    team(type: self.type,members: log.teams[0].member)
                    Text("VS")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                        .padding([.top, .bottom], 6)
                    team(type: self.type,members: log.teams[1].member)
                }
            } else {
                iphone
            }
        }
       
    }
    
    var iphone: some View {
        Group {
            VStack(spacing: 0) {
                
                if type.isShowdown {
                    ScrollView(.horizontal) {
                        
                        if type == .trioShowdown {
                            Grid(verticalSpacing: 40) {
                                GridRow {
                                    team(type: self.type,members: log.teams[0].member)
                                    team(type: self.type,members: log.teams[1].member)
                                }
                                GridRow {
                                    team(type: self.type,members: log.teams[2].member)
                                    team(type: self.type,members: log.teams[3].member)
                                }
                            }
                            .padding()
                        } else if type == .duoShowdown {
                            HStack(spacing: 40) {
                                ForEach(log.teams) { t in
                                    team(type: self.type, members: t.member)
                                }
                            }
                            .padding()
                        } else if type == .soloShowdown {
                            LazyHGrid(
                                rows: [GridItem(.flexible(), spacing: -10),GridItem(.flexible())],
                                spacing: 30
                            ) {
                                ForEach(log.teams[0].member) { m in
                                    member(m)
                                }
                            }
                            .padding()
                        }
                        
                    }
                } else {
                    
                    
                    
                    team(type: self.type,members: log.teams[0].member)
                    Text("VS")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                        .padding([.top, .bottom], 6)
                    team(type: self.type,members: log.teams[1].member)
                }
                
            }
        }
    }
    
    
    
    func team(type: CardType, members: [Member]) -> some View {
        
        Group {
            if type == .duoShowdown {
                VStack {
                    member(members[0])
                    member(members[1])
                }
            } else {
                
                HStack {
                    ForEach(members.indices, id: \.self) { index in
                        member(members[index])
                        if index != members.count - 1 {
                            Spacer()
                        }
                    }
                }
                .padding([.leading, .trailing], 25)
            }
        }
        
    }
    
    private func member(_ member: Member) -> some View {
        VStack(spacing: 0) {
            Image(member.brawler.uppercased())
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, alignment: .trailing) // ✅ 오른쪽 정렬
            
            Text(member.name)
                .font(.system(size: 10))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 23)
                .padding(2)
        }
        .frame(width: 80, height: 100)
        .clipped()
        .roundedCornerWithBorder(
            lineWidth: 3,
            borderColor: member.starPlayer ? .yellow : .clear,
            backgroundColor: Color(hexString: "FFFFFF", opacity: 0.5),
            radius: 12
        )
    }
}

#Preview {
    BattleLogView(
        vm: RxDIContainer.shared.makeBattleLogViewModel()
    )
}
