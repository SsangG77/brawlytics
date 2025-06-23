//
//  UserView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/23/25.
//

import SwiftUI

struct UserView: View {
    
    let overlapCardVM: OverlapCardViewModel = OverlapCardViewModel(type: .user)
    
    var body: some View {
        OverlapCardView(vm: overlapCardVM, frontView: {
            HStack {
                NamesView
                Spacer()
                Image("master")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85) // 원하는 너비
                    .padding(.trailing, 30)

            }
        }, backView: {
                HStack {
                    HStack(spacing: 20) {
                        TrophiesView(label: "Total Trophies", count: 54000)
                        TrophiesView(label: "Max Trophies", count: 64000)
                    }
                    
                    Spacer()
                
                    Image(systemName: "chevron.compact.forward")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                }
                .padding(.leading, 30)
                .padding(.trailing, 12)
        })
    }
    
    var NamesView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("NickName")
                .foregroundStyle(.white)
                .fontWeight(.heavy)
                .font(.system(size: 27))
            HStack {
                Image("club")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20) // 원하는 너비
                Text("Club Name")
                    .foregroundStyle(.white)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .opacity(0.7)
            }
        }
        .padding(.leading, 30)
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

#Preview {
    UserView()
    Spacer()
}
