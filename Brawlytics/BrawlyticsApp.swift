//
//  BrawlyticsApp.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import SwiftUI
import SwiftData

@main
@available(iOS 17.0, *)
struct BrawlyticsApp: App {
   
    let diContainer = DIContainer.shared
    let rxDiContainer = RxDIContainer.shared

    var body: some Scene {
        WindowGroup {
            ContentView(
//                calculateVM: diContainer.makeCalculateViewModel(),
                calculateVM: rxDiContainer.makeCalculateViewModel(),
                brawlersVM: diContainer.makeBrawlersViewModel()
            )
        }
        
    }
}
