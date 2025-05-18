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
    let viewModel: CalculateViewModel
    let brawlersViewModel: BrawlersViewModel = BrawlersViewModel()
    
    init() {

        let useCase = CalculateUseCaseImpl()
        self.viewModel = CalculateViewModel(calculateUseCase: useCase)
    }
    
    var body: some View {
        TabView {
            Group {
                CalculateView(calculateViewModel: viewModel, brawlersViewModel: brawlersViewModel)
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
        .onAppear {
            UserDefaults.standard.set([], forKey: "searchTextArray")
        }
    }
}
