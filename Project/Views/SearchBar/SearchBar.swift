//
//  SearchBar.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import SwiftUI


@available(iOS 17.0, *)
struct SearchBar: View {
    @State var showHistory:Bool = false
    @Binding var allBrawlersStandard: [BrawlerStandard]
    @Binding var clicked: Bool
    @Binding var isLoading: Bool
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    @ObservedObject var searchBarViewModel: SearchBarViewModel
    @StateObject var service: BrawlersService = BrawlersService()
    
    
    
    @State var iphoneWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    

    var body: some View {
        
        GeometryReader { geo in
            
            @State var ipadWidth = geo.size.width * 0.7
            
            ZStack(alignment: .top) {
                if showHistory {
                    SearchHistoryView(ipadWidth: $ipadWidth)
                        .environmentObject(searchBarViewModel)
                }
                
                VStack {
                    ZStack {
                        HStack {
                            TextField("유저 태그 입력", text: $searchBarViewModel.searchText, onEditingChanged: { isEdit in
                                withAnimation {
                                    showHistory = isEdit
                                }
                            })
                            .padding(.horizontal, 10)
                            .frame(height: 65)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 10)
                            )
                            .cornerRadius(15)
                        }
                        
                        HStack {
                            Spacer() // 버튼을 오른쪽으로 이동
                            Button(action: {
                                //키보드 비활성화 시키기
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                                if searchBarViewModel.searchText != "" {
                                    searchBarViewModel.saveSearchText(searchBarViewModel.searchText)
                                    withAnimation {
                                        clicked = true
                                    }
                                    showHistory = false
                                    
                                    // 로딩 시작
                                    withAnimation {
                                        isLoading = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            
                                            allBrawlersStandard = service.allBrawlers
                                        }
                                        
                                        // 로딩 종료
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                isLoading = false
                                            }
                                        }
                                        
                                        calculateViewModel.getBrawlers(searchBarViewModel.searchText)
                                    }
                                }
                                
                                
                            }) {
                                Image(systemName: "magnifyingglass") // 돋보기 이미지
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(11)
                            }
                            .padding(.trailing, 10)
                            
                        }
                    }
                    Spacer()
                    
                }
                .frame(width : Constants.isPad() ? ipadWidth : iphoneWidth, height: 120)
            }
            .padding([.leading, .trailing])
        }
        .onDisappear {
            searchBarViewModel.searchText = ""
            clicked = false
            showHistory = false
            allBrawlersStandard = []
            calculateViewModel.brawlers = []
            
            appState.totalCoin = 0
            appState.totalPP = 0
            appState.totalCredit = 0
        }
    }
}
