//
//  Constants.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import Foundation
import UIKit

struct Constants {
    
    //localhost
//    static let serverURL = "http://192.168.31.200:3000/"
    
    static let serverURL = "https://brawlytics-server.com/"
    
    
    //플레이어태그로 브롤러들의 정보를 가져오는 url
    static let getBrawlersURL = serverURL + "brawlers"
    
    // 유저 트로피 정보 가져오기
    static let fetchUserProfileURL = serverURL + "user"
    
    // 브롤러들 트로피 정보 가져오기
    static let fetchBrawlersTrophyURL = serverURL + "brawlers/trophy"
    
    // 전적 가져오기
    static let fetchBattleLogURL = serverURL + "battlelog"
    
    // 브롤러별 트로피 그래프용 데이터 가져오기
    static let fetchTrophyGraphURL = serverURL + "trophies"
    
    //https://brawlytics-server.com/brawlers?playertag=22yjv82rp
    
    static func myPrint<T>(title:String, content:T) {
        print("======================= \(title) =======================print")
        print(content)
        print("")
    }
    
    static func isPad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        return false
    }
}
