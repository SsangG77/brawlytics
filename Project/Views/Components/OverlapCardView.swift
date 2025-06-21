//
//  OverlapCardView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI


struct OverlapCardView: View {
    
    let alignment: Alignment
    let type: CardType
    
    
    init(
        alignment: Alignment,
        type: CardType
    
    ) {
        self.alignment = alignment
        self.type = type
    }
    
    
    var body: some View {
        ZStack(alignment: alignment) {
            
            // 뒷 카드
            VStack {
                
            }
            .frame(width: 300, height: 150)
            .roundedCornerWithBorder(backgroundColor: type.backColor)

            // 앞 카드
            VStack {
                
            }
            .frame(width: 300, height: 70)
            .roundedCornerWithBorder(backgroundColor: type.frontColor)
                
        }
        .padding()
        
        
    }
}

enum CardType {
    case win, lose, `default`
    
    var frontColor: Color {
        switch self {
        case .win: return Color.lightRed
        case .lose: return Color.lightBlue
        case .default: return Color.deepColor
        }
    }
    
    var backColor: Color {
        switch self {
        case .win: return Color.deepRed
        case .lose: return Color.deepBlue
        case .default: return Color.lightColor
        }
    }
}





#Preview {
    OverlapCardView(alignment: .top, type: .default)
    OverlapCardView(alignment: .bottom, type: .win)
    OverlapCardView(alignment: .bottom, type: .lose)
    
    Spacer()
        
}
