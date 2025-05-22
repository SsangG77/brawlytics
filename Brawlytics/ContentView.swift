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
    @StateObject var viewModel: CalculateViewModel
    @StateObject var brawlersViewModel: BrawlersViewModel
    init() {
        let useCase = CalculateUseCaseImpl()
        _viewModel = StateObject(wrappedValue: CalculateViewModel(calculateUseCase: useCase))
        
        let service = BrawlersService()
        let dataSource = HyperchargeDataSourceImpl()
        let repository = BrawlersRepositoryImpl(service: service, dataSource: dataSource)
        let brawlersUseCase = BrawlersUseCaseImpl(repository: repository)
        _brawlersViewModel = StateObject(
            wrappedValue: BrawlersViewModel(
                repository: repository,
                useCase: brawlersUseCase,
                judge: BrawlerJudgeImpl()
            )
        )
        
    }
    
    var body: some View {
        TabView {
            Group {
                CalculateView()
                .environmentObject(appState)
                .environmentObject(viewModel)
                .tabItem {
                    Label("Calculator", systemImage: "number")
                        
                }
                
                HyperchargeView(viewModel: brawlersViewModel)
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
