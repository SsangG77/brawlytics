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
    
//    @StateObject private var appState = AppState()
    
#warning("RX 방식 변경을 위한 테스트")
    @StateObject var calculateVM: RxCalculateViewModel
    @StateObject var brawlersVM: BrawlersViewModel
    
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
//                .environmentObject(appState)
                .environmentObject(calculateVM)
                .tabItem {
                    Label("Calculator", systemImage: "number")
                        
                }
                
//                HyperchargeView(viewModel: brawlersVM)
////                    .environmentObject(appState)
//                    .tabItem {
//                        Label("Hyper charge", systemImage: "flame")  
//                    }
                
                PlayerProfileView(vm: PlayerProfileViewModel(
                    useCase: PlayerProfileUseCaseImpl(
                        repository: PlayerProfileRepositoryImpl(
                            dataSource: MockPlayerProfileDataSourceImpl()
                        )
                    )
                ))
                    .tabItem {
                        Label("Profile", systemImage: "chart.bar")
                    }
                
            }
            .toolbarBackground(Color(hexString:"283548"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            
        }
        .background(Color.backgroundColor)
        .onAppear {
            UserDefaults.standard.set([], forKey: "searchTextArray")
        }
    }
}
