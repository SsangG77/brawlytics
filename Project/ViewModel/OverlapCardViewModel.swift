//
//  OverlapCardViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/23/25.
//

import Foundation
import SwiftUI



class OverlapCardViewModel: ObservableObject {
    let type: CardType
    let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    init(type: CardType) {
        self.type = type
    }
    
    var alignment: Alignment {
        switch type {
            case .win, .lose: return .bottom
            case .user, .brawler: return .top
        }
    }
    
    var cardWidth: CGFloat {
        isPad ? UIScreen.main.bounds.width * 0.4 : UIScreen.main.bounds.width * 0.8
    }
    
    var cardBackHeight: CGFloat {
        isPad ? 150 : type.backHeight
    }
    
    var cardFrontHeight: CGFloat {
        isPad ? 150 : type.frontHeight
    }
    
    var backColor: Color {
        type.backColor
    }
    
    var frontColor: Color {
        type.frontColor
    }

    var cardRadius: CGFloat = 27
    
    var fontColor: Color {
        type.fontColor
    }
    
}

