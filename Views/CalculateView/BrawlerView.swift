//
//  BrawlerView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/4/24.
//

import SwiftUI


//브롤러 한개당 정보 모음
struct BrawlerView: View {
    var body: some View {
        
        @State var totalHeight: CGFloat = 270
        @State var brawlerHeight: CGFloat = 220
        
        
        ZStack {
            VStack {
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: totalHeight)
            .cornerRadius(20)
            .background(Color(hexString: "576E90"))
            .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
            
            
            VStack {
                
                //브롤러 정보들
                VStack {
                    
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: brawlerHeight)
                .cornerRadius(20)
                .background(Color(hexString: "6D8CB9"))
                .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
                
                //해당 브롤러 재화 표시 부분
                VStack {
                    
                }
                .frame(height: totalHeight - brawlerHeight)
            }
            .frame(height: totalHeight)
            
            
            
        }
        
        
    }
}


struct SkillView: View {
    var body: some View {
        
        GeometryReader { geo in
            HStack {
                Text("Skill view")
            }
            .frame(width: geo.size.width * 0.5, height: 100, alignment: .center)
            .background(.blue)
        }
    }
}


#Preview {
    BrawlerView()
}
