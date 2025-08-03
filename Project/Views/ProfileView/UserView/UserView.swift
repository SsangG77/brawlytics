//
//  UserView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/23/25.
//

import SwiftUI

struct UserView: View {
    
    let overlapCardVM: OverlapCardViewModel = OverlapCardViewModel(type: .user)
    
    let user: UserTrophyModel
    
    init(user: UserTrophyModel) {
        self.user = user
    }
    
    var body: some View {
        OverlapCardView(vm: overlapCardVM, frontView: {
            HStack {
                NamesView
                Spacer()

            }
        }, backView: {
                HStack {
                    HStack(spacing: 20) {
                        TrophiesView(label: "Total Trophies", count: user.total)
                        TrophiesView(label: "Max Trophies", count: user.max)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "gamecontroller.fill")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                
                    Image(systemName: "chevron.compact.forward")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                }
                .padding(.leading, 30)
                .padding(.trailing, 12)
        })
    }
    
    var NamesView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(user.nickName)
//            Text("Sangjin")
                .foregroundStyle(.white)
                .fontWeight(.heavy)
                .font(.system(size: 37))
            HStack {
                Spacer()
                Image("club")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30) // 원하는 너비
                Text(user.club)
                    .foregroundStyle(.white)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .opacity(0.7)
            }
        }
        .padding(.horizontal, 30)
    }
    
    private func TrophiesView(label: String, count: Int) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(spacing: 5) {
                Image("trophy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text(label)
                    .font(.system(size: 13))
                    .foregroundStyle(.white)
            }
            
            Text(String(count))
                .fontWeight(.bold)
                .font(.system(size: 27))
                .foregroundStyle(.white)
        }
    }
    
    
}

//#Preview {
//    UserView()
//    Spacer()
//}
