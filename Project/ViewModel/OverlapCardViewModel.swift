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
        case .win, .lose, .draw, .soloShowdown, .duoShowdown, .trioShowdown : return .bottom
        case .user, .brawler, .graph: return .top
        
        }
    }
    
    var cardWidth: CGFloat {
        
        if isPad {
            if [.win, .lose, .soloShowdown, .duoShowdown, .trioShowdown].contains(type) {
                UIScreen.main.bounds.width * 0.7
            } else {
                UIScreen.main.bounds.width * 0.4
            }
        } else {
            UIScreen.main.bounds.width * 0.9
        }
    }
    
    var cardBackHeight: CGFloat {
//        type.backHeight
        
        if isPad {
            if type == .user {
                type.frontHeight
            } else {
                type.backHeight
            }
        } else {
            type.backHeight
        }
    }
    
    var cardFrontHeight: CGFloat {
//        isPad ? 150 : type.frontHeight
        type.frontHeight
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

