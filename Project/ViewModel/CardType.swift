//
//  CardType.swift
//  Brawlytics
//
//  Created by 차상진 on 6/25/25.
//

import Foundation
import SwiftUI


enum CardType {
    case win, lose, user, brawler, graph
    
    var frontColor: Color {
        switch self {
        case .win: return Color.lightBlue
        case .lose: return Color.lightRed
        case .user, .brawler, .graph: return Color.deepColor
        }
    }
    
    var backColor: Color {
        switch self {
        case .win: return Color.deepBlue
        case .lose: return Color.deepRed
        case .user, .brawler, .graph: return Color.lightColor
        }
    }
    
    var frontHeight: CGFloat {
        switch self {
        case .win, .lose: return 300
        case .user : return 100
        case .brawler : return 70
        case .graph: return 80
        }
    }
    
    var backHeight: CGFloat {
        switch self {
        case .win, .lose: return frontHeight + 70
        case .user: return 185
        case .brawler : return 170
        case .graph: return UIScreen.main.bounds.height * 0.7
        }
    }
    
    var fontColor: Color {
        switch self {
        case .win : return Color(hexString: "8684FF")
        case .lose : return Color(hexString: "FF8080")
        default: return Color.white
        }
    }
    
}
