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
    
    @StateObject private var appState = AppState()
    @StateObject var calculateVM: CalculateViewModel
    @StateObject var brawlersVM: BrawlersViewModel
    
    init(
        calculateVM: CalculateViewModel,
        brawlersVM: BrawlersViewModel
    ) {
        _calculateVM = StateObject(wrappedValue: calculateVM)
        _brawlersVM = StateObject(wrappedValue: brawlersVM)
    }
    
    var body: some View {
        TabView {
            Group {
                CalculateView()
                .environmentObject(appState)
                .environmentObject(calculateVM)
                .tabItem {
                    Label("Calculator", systemImage: "number")
                        
                }
                
                HyperchargeView(viewModel: brawlersVM)
                    .environmentObject(appState)
                    .tabItem {
                        Label("Hyper charge", systemImage: "flame")
                            
                    }
                
            }
            .toolbarBackground(Color(hexString:"283548"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            
        }
        .onAppear {
            UserDefaults.standard.set([], forKey: "searchTextArray")
        }
    }
}
