//
//  BattleLogView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/23/25.
//

import SwiftUI

struct BattleLogView: View {
    var body: some View {
        ZStack {
            Color.backgroundColor // 배경 뷰 (예: 색상)
                .ignoresSafeArea() // 화면 전체로 확장
            
            ScrollView {            
                SingleBattleLogView()
            }
            
        }
        .navigationTitle("Battle Logs") // ✅ 제목만 지정
        .navigationBarTitleDisplayMode(.inline) // 선택 사항
    }
}



struct SingleBattleLogView: View {
    
    let vm: OverlapCardViewModel = OverlapCardViewModel(type: .lose)
    let singleBattleLogVM: SingleBattleLogViewModel = SingleBattleLogViewModel()
    
    
    var body: some View {
        OverlapCardView(vm: vm, frontView: {
            log
        }, backView: {
           header
        })
    }
    
    
    var header: some View {
        HStack(spacing: 0) {
            Image(singleBattleLogVM.checkMode(mode: "brawlBall"))
                .resizable()
                .scaledToFit()
                .padding()
            
            Text("Map name")
                .lineLimit(1) // 한 줄로 제한
                .minimumScaleFactor(0.5) // 최소 50% 크기까지 축소
                .font(.title3)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(vm.type == .win ? "WIN" : "LOSE")
                .fontWeight(.bold)
                .font(.system(size: 30))
                .foregroundStyle(vm.fontColor)
                .padding(.trailing, 20)
        }
    }
    
    var log: some View {
        
        Group {
            if vm.isPad {
                HStack(spacing: 0) {
                    team
                    Text("VS")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                        .padding([.top, .bottom], 6)
                    team
                }
            } else {
                VStack(spacing: 0) {
                    team
                    Text("VS")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                        .padding([.top, .bottom], 6)
                    team
                }
            }
        }
       
    }
    
    var team: some View {
        HStack {
            member(false)
            Spacer()
            member(false)
            Spacer()
            member(true)
        }
        .padding([.leading, .trailing], 25)
    }
    
    private func member(_ star: Bool) -> some View {
        VStack(spacing: 0) {
            Image("KENJI")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, alignment: .trailing) // ✅ 오른쪽 정렬
            
            Text("NickName")
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
            borderColor: star ? .yellow : .clear,
            backgroundColor: Color(hexString: "FFFFFF", opacity: 0.5),
            radius: 12
        )
        
    }
    
    
    
}

#Preview {
    BattleLogView()
    
    Spacer()
}
