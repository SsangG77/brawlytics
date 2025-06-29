//
//  CalculateView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import SwiftUI
import Foundation
import RxSwift

@available(iOS 17.0, *)
struct CalculateView: View {
    
    
    @State var allBrawlersStandard: [BrawlerStandard] = []
    @State var clicked = false
    @State var isLoading: Bool = false
    @State var error: Bool = false
    
    //total money icon size
    let iconSize: CGFloat = 20
    let fontSize: CGFloat = 20
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var calculateViewModel: RxCalculateViewModel
    
    let diContainer = DIContainer.shared
    let disposeBag = DisposeBag()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                
                let width = Constants.isPad() ? geo.size.width * 0.3 - 10 : geo.size.width * 0.9
                

//                VStack(spacing : 0) {
                VStack(spacing : 20) {
                    calculateViewModel.DynamicStack(isPad: Constants.isPad()) {
                        
                        SearchBar(
                            clicked: $clicked,
                            searchBarViewModel: diContainer.makeSearchBarViewModel()
                        )
                        .environmentObject(calculateViewModel)
                        .environmentObject(appState)
                        .zIndex(1)
                        
                        MoneyBoxView()
                            .environmentObject(appState)
                    }
                    .frame(height: 110)
            
//                    NavigationLink(destination:
//                                    HyperchargeView(viewModel: diContainer.makeBrawlersViewModel())
//                        .navigationTitle(NSLocalizedString("hypercharge_select", comment: ""))
//                    ) {
//                        Label(NSLocalizedString("hypercharge_select", comment: ""), systemImage: "flame")
//                            .foregroundColor(.black)
//                            .font(.system(size: 17, weight: .bold))
//                            .padding(.vertical, 10)
//                    }
                    if calculateViewModel.isError {
                        VStack {
                            Spacer()
                            Text(calculateViewModel.errorMessage)
                                .fontDesign(.rounded)
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                            Text(NSLocalizedString("research", comment: ""))
                                .foregroundColor(.white)
                    
                            Spacer()
                        }
                        .frame(height: geo.size.height - 170)
                        
                    } else {
                        ScrollView {
                            
                            ForEach(Role.allCases, id: \.self) { role in
                                let filtered = allBrawlersStandard.filter { $0.role == role }
                                RoleBrawlerSection(
                                    role: role,
                                    filtered: filtered,
                                    width: width,
                                    clicked: clicked,
                                    isLoading: $isLoading
                                )
                                .environmentObject(appState)
                                
                            }
                        }
                        .frame(height: geo.size.height - 170)
                    }
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }//geo
            .ignoresSafeArea(.keyboard)
            .background(Color(hexString: "37475F"))
            .onAppear {
                allBrawlersStandard = calculateViewModel.getBrawlersStandard()
                
                calculateViewModel.isLoadingSubject
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { value in
                        self.isLoading = value
                        print("isLoading: \(self.isLoading)---------print")
                    })
                    .disposed(by: disposeBag)
                
                
            }
        }
    }
}


struct RoleBrawlerSection: View {
    let role: Role
//    let allBrawlers: [BrawlerStandard]
    let filtered: [BrawlerStandard]
    let width: CGFloat
    let clicked: Bool
    @Binding var isLoading: Bool

    @EnvironmentObject var appState: AppState
    let vm = ClassesTitleViewModel()
    let diContainer = DIContainer.shared

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
                        BrawlerEmptyView(width: width)
                    } else {
                        ForEach(filtered, id: \ .id) { brawler in
                            BrawlerView(
                                width: width,
                                brawlerStandard: brawler,
                                viewModel: diContainer.makeBrawlersViewModel()
                            )
                            .environmentObject(appState)
                        }
                    }
                }
            }
            .scrollTargetLayout()
            .frame(height: 270)
        }
        .frame(height: 280)
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.1 / 2)
    }
}
