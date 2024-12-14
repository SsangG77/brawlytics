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

    var body: some View {
        TabView {
            Group {
                CalculateView()
                    .ignoresSafeArea(.keyboard, edges: .all)
                    .environmentObject(appState)
                    .tabItem {
                        Label("Calculator", systemImage: "number")
                            
                    }
                
                HyperchargeView()
                    .tabItem {
                        Label("Hyper charge", systemImage: "flame")
                            
                    }
                
            }
            .toolbarBackground(Color(hexString:"283548"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        .onAppear {
            UserDefaults.standard.set([], forKey: "searchTextArray")
        }

    }

  
}

//#Preview {
//    if #available(iOS 17.0, *) {
//        ContentView()
//    } else {
//        // Fallback on earlier versions
//    }
//}
