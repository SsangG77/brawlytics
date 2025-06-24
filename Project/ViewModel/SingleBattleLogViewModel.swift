//
//  SingleBattleLogViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/24/25.
//

import Foundation

class SingleBattleLogViewModel: ObservableObject {
    
    
    func checkMode(mode: String) -> String {
        switch mode {
        case "gemGrab": return "gem_grab_icon"
        case "bounty": return "bounty_icon"
        case "brawlBall": return "brawl_ball_icon"
        case "heist": return "heist_icon"
        case "hotZone": return "hot_zone_icon"
        case "knockOut": return "knock_out_icon"
        case "trioShowdown", "duoShowdown", "showdown": return "showdown_icon"
        case "duels": return "duels_icon"
            
            
        default: return ""
        }
    }
}
