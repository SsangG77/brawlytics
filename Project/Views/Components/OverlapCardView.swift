//
//  OverlapCardView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI

struct OverlapCardView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // 전체 배경 박스
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 3)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0.24, green: 0.30, blue: 0.42)) // 아래쪽 색
                )
                .frame(width: 300, height: 150)
            // 상단 박스 (겹쳐지는 형태)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.07, green: 0.11, blue: 0.20)) // 위쪽 색
                .frame(width: 300, height: 70)
                
        }
        .padding()
        .background(Color(.black))
        
    }
}

#Preview {
    OverlapCardView()
}
