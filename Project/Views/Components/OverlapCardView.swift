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
    let isPad: Bool
    
    
    // UI 설정값
    private var cardRadius: CGFloat = 30 * 0.9
    var width: CGFloat {
        return isPad ? 200 : UIScreen.main.bounds.width * 0.85
    }
    
    init(
        alignment: Alignment,
        type: CardType,
        isPad: Bool
    ) {
        self.alignment = alignment
        self.type = type
        self.isPad = isPad
    }
    
    
    var body: some View {
        
        Group {
            if isPad {
                HStack {
                    backCard
                    Spacer()
                    frontCard
                }
            } else {
                ZStack(alignment: alignment) {
                    backCard
                    frontCard
                }
            }
        }
        .padding()
    }
    
    private var backCard: some View {
        VStack {
            
        }
        .frame(width: width, height: isPad ? 150 : type.backHeight)
        .roundedCornerWithBorder(
            backgroundColor: type.backColor,
            radius: cardRadius
        )
    }
    
    private var frontCard: some View {
        VStack {
            
        }
        .frame(width: width, height: isPad ? 150 : type.frontHeight)
        .roundedCornerWithBorder(
            backgroundColor: type.frontColor,
            radius: cardRadius
        )
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
    
    var frontHeight: CGFloat {
        switch self {
        case .win, .lose: return 270
        case .default: return 80
        }
    }
    
    var backHeight: CGFloat {
        switch self {
            case .win, .lose: return 330
            case .default: return 150
        }
    }
    
}





#Preview {
    OverlapCardView(alignment: .top, type: .default,isPad: false)
    OverlapCardView(alignment: .bottom, type: .win,isPad: true)
    OverlapCardView(alignment: .bottom, type: .lose,isPad: false)
    
    Spacer()
        
}
