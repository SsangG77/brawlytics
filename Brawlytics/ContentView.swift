//
//  ContentView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct ContentView: View {
    
#warning("RX 방식 변경을 위한 테스트")
    @StateObject var calculateVM: RxCalculateViewModel
    @StateObject var brawlersVM: BrawlersViewModel
    @StateObject var playerProfileVM = RxDIContainer.shared.makePlayerProfileViewModel()
    
    
    init(
        calculateVM: RxCalculateViewModel,
        brawlersVM: BrawlersViewModel
    ) {
        _calculateVM = StateObject(wrappedValue: calculateVM)
        _brawlersVM = StateObject(wrappedValue: brawlersVM)
    }
    
    var body: some View {
        TabView {
            Group {
                CalculateView()
                    .environmentObject(calculateVM)
                    .tabItem {
//                        Label("Calculator", systemImage: "number")
                        Image(systemName: "number")
                        
                    }
                    
                
                PlayerProfileView(vm: playerProfileVM)
                    .tabItem {
//                        Label("Profile", systemImage: "chart.bar")
                        Image(systemName: "chart.bar")
                            
                    }
                    
                
                SettingView()
                    .tabItem {
//                        Label("Setting", systemImage: "gear")
                        Image(systemName: "gear")
                            
                    }
                
                
                
            }
            .toolbarBackground(Color(hexString:"283548"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            
        }
        .tint(.black)
        .background(Color.backgroundColor)
        .onAppear {
            UserDefaults.standard.set([], forKey: "searchTextArray")
        }
    }
}
