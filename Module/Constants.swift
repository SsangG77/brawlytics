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
    static let serverURL = "http://127.0.0.1:3000/"
    
    
    
//    static let ip = "192.168.31.200"
//    static let serverURL = "https://brawlytics-server.com/"
    
    
    //플레이어태그로 브롤러들의 정보를 가져오는 url
    static let getBrawlersURL = serverURL + "brawlers"
    static let fetchUserProfileURL = serverURL + "user"
    static let fetchBrawlersTrophyURL = serverURL + "brawlersTrophy"
    
    
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
