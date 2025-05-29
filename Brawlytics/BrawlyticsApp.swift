//
//  BrawlyticsApp.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

@main
@available(iOS 17.0, *)
struct BrawlyticsApp: App {
   
    let diContainer = DIContainer.shared
    let rxDiContainer = RxDIContainer.shared
    
    init() {
        MobileAds.shared.start(completionHandler: nil)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(
                calculateVM: rxDiContainer.makeCalculateViewModel(),
                brawlersVM: diContainer.makeBrawlersViewModel()
            )
        }
        
    }
}
