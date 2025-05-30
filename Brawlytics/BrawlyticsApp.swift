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
    
//    init() {
//        MobileAds.shared.start(completionHandler: nil)
//    }

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                calculateVM: rxDiContainer.makeCalculateViewModel(),
                brawlersVM: diContainer.makeBrawlersViewModel()
            )
        }
        
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    MobileAds.shared.start(completionHandler: nil)

    return true
  }
}
