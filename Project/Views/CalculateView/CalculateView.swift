//
//  CalculateView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import SwiftUI


@available(iOS 17.0, *)
struct CalculateView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State var allBrawlersStandard: [BrawlerStandard] = []
    @State var clicked = false
    @State private var isLoading: Bool = false
    
    //total money icon size
    let iconSize: CGFloat = 20
    let fontSize: CGFloat = 20
    
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    
    var body: some View {
        
        GeometryReader { geo in
            
            let width = Constants.isPad() ? geo.size.width * 0.3 - 10 : geo.size.width * 0.9
            
            
            VStack(spacing : 0) {
                
                calculateViewModel.DynamicStack(isPad: Constants.isPad()) {

                    let repository = SearchHistoryRepositoryImpl()
                    let searchBarVM = SearchBarViewModel(repository: repository)
                    
                        SearchBar(
                            allBrawlersStandard: $allBrawlersStandard,
                            clicked: $clicked,
                            isLoading: $isLoading,
                            searchBarViewModel: searchBarVM
//                            brawlersViewModel: brawlersViewModel
//                            service: service
                        )
                        .environmentObject(calculateViewModel)
                        .environmentObject(appState)
                        .zIndex(1)
                        
                        
                        MoneyBoxView()
                            .environmentObject(appState)
                }
                
                ScrollView {
                    
                    RoleBrawlerSection(
                        role: .tanker,
                        allBrawlers: allBrawlersStandard,
                        width: width,
                        clicked: clicked,
                        isLoading: isLoading
                    )
                    .environmentObject(appState)
                    .environmentObject(calculateViewModel)

                    RoleBrawlerSection(
                        role: .assassin,
                        allBrawlers: allBrawlersStandard,
                        width: width,
                        clicked: clicked,
                        isLoading: isLoading
                    )
                    .environmentObject(appState)
                    .environmentObject(calculateViewModel)

                    RoleBrawlerSection(
                        role: .supporter,
                        allBrawlers: allBrawlersStandard,
                        width: width,
                        clicked: clicked,
                        isLoading: isLoading
                    )
                    .environmentObject(appState)
                    .environmentObject(calculateViewModel)

                    RoleBrawlerSection(
                        role: .controller,
                        allBrawlers: allBrawlersStandard,
                        width: width,
                        clicked: clicked,
                        isLoading: isLoading
                    )
                    .environmentObject(appState)
                    .environmentObject(calculateViewModel)

                    RoleBrawlerSection(
                        role: .damageDealer,
                        allBrawlers: allBrawlersStandard,
                        width: width,
                        clicked: clicked,
                        isLoading: isLoading
                    )
                    .environmentObject(appState)
                    .environmentObject(calculateViewModel)
                    
                    RoleBrawlerSection(
                        role: .marksmen,
                        allBrawlers: allBrawlersStandard,
                        width: width,
                        clicked: clicked,
                        isLoading: isLoading
                    )
                    .environmentObject(appState)
                    .environmentObject(calculateViewModel)

                    
                    
                    RoleBrawlerSection(
                        role: .thrower,
                        allBrawlers: allBrawlersStandard,
                        width: width,
                        clicked: clicked,
                        isLoading: isLoading
                    )
                    .environmentObject(appState)
                    .environmentObject(calculateViewModel)
                        

                    
                }
                .frame(height: geo.size.height - 120)
                
                
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
        }//geo
        .ignoresSafeArea(.keyboard)
        .background(Color(hexString: "37475F"))
        
        
    }
}


struct RoleBrawlerSection: View {
    let role: Role
    let allBrawlers: [BrawlerStandard]
    let width: CGFloat
    let clicked: Bool
    let isLoading: Bool

    @EnvironmentObject var appState: AppState
    let vm = ClassesTitleViewModel()

    var body: some View {
        if !isLoading && clicked {
            ClassesTitleView(
                imageName: vm.getImageName(role: role),
                title: vm.getClassTitle(role: role)
            )
            .padding(.top, 7)
        }

        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if clicked {
                    if isLoading {
                        BrawlerEmptyView()
                    } else {
                        let filtered = allBrawlers.filter { $0.role == role }
                        if filtered.isEmpty {
                            Text("No Data Found")
                        } else {
                            ForEach(filtered, id: \.id) { brawler in
                                BrawlerView(width: width, brawlerStandard: brawler)
                                    .environmentObject(appState)
                            }
                        }
                    }
                }
            }
            .scrollTargetLayout()
            .frame(height: 280)
        }
        .frame(height: 280)
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.1 / 2)
    }
}
