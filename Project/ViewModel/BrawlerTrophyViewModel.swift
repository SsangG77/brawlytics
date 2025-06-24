//
//  BrawlerTrophyViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/24/25.
//

import Foundation


class BrawlerTrophyViewModel: ObservableObject {
    
    
    func getRank(for score: Int) -> String {
        if score >= 1000 {
            return "tiermax"
        }

        let rank = score / 20 + 1
        return "rank\(rank)"
    }

    
}
