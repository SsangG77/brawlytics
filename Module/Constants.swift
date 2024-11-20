//
//  Constants.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import Foundation

struct Constants {
    
    static let ip = "192.168.31.200"
    static let serverURL = "http://\(ip):4000/"
    
    //플레이어태그로 브롤러들의 정보를 가져오는 url
    static let getBrawlersURL = serverURL + "brawlers"
    
    
    
    
    
    static func myPrint<T>(title:String, content:T) {
        print("")
        print("======================= \(title) =======================")
        print(content)
        print("")
        
    }
    
    
    
}
