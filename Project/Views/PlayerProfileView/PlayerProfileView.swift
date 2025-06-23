//
//  PlayerProfileView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI

struct PlayerProfileView: View {
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.backgroundColor // 배경 뷰 (예: 색상)
                    .ignoresSafeArea() // 화면 전체로 확장
                
                ScrollView {
                    NavigationLink(destination: BattleLogView()) {
                        UserView()
                    }
                }
            }
        }
        
    }
}


#Preview {
    PlayerProfileView()
    
}
