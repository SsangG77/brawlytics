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
    
    @Binding var tanker_brawlers_standard: [Brawler_standard]
    @Binding var assassin_brawlers_standard: [Brawler_standard]
    @Binding var supporter_brawlers_standard: [Brawler_standard]
    @Binding var damage_dealers_brawlers_standard: [Brawler_standard]
    @Binding var controller_brawlers_standard: [Brawler_standard]
    @Binding var marksmen_brawlers_standard: [Brawler_standard]
    @Binding var throw_brawlers_standard: [Brawler_standard]
    
    @Binding var clicked: Bool
    @Binding var isLoading: Bool
    
    
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    @EnvironmentObject var appState: AppState
    
    
    @StateObject var brawlersViewModel = BrawlersViewModel()
    
    @State var iphoneWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    

    var body: some View {
        
        GeometryReader { geo in
            
            @State var ipadWidth = geo.size.width * 0.7
            
            ZStack(alignment: .top) {
                if showHistory {
                    SearchHistoryView(ipadWidth: $ipadWidth)
                        .environmentObject(calculateViewModel)
                }
                
                VStack {
                    ZStack {
                        HStack {
                            TextField("유저 태그 입력", text: $calculateViewModel.searchText, onEditingChanged: { isEdit in
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
                                
                                if calculateViewModel.searchText != "" {
                                    calculateViewModel.saveSearchText(calculateViewModel.searchText)
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
                                            tanker_brawlers_standard = brawlersViewModel.tanker_brawlers_standard
                                            assassin_brawlers_standard = brawlersViewModel.assassin_brawlers_standard
                                            supporter_brawlers_standard = brawlersViewModel.supporter_brawlers_standard
                                            controller_brawlers_standard = brawlersViewModel.controller_brawlers_standard
                                            damage_dealers_brawlers_standard = brawlersViewModel.damage_dealers_brawlers_standard
                                            marksmen_brawlers_standard = brawlersViewModel.marksmen_brawlers_standard
                                            throw_brawlers_standard = brawlersViewModel.throw_brawlers_standard
                                            
                                        }
                                        
                                        // 로딩 종료
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                isLoading = false
                                            }
                                        }
                                        
                                        calculateViewModel.getBrawlers()
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
            Constants.myPrint(title: "Searchbar disappear", content: "")
            calculateViewModel.searchText = ""
            clicked = false
            showHistory = true
            tanker_brawlers_standard = []
            assassin_brawlers_standard = []
            supporter_brawlers_standard = []
            controller_brawlers_standard = []
            damage_dealers_brawlers_standard = []
            marksmen_brawlers_standard = []
            throw_brawlers_standard = []
            calculateViewModel.brawlers = []
            
            appState.totalCoin = 0
            appState.totalPP = 0
            appState.totalCredit = 0
        }
        
        
        
        
        
    }
}



@available(iOS 17.0, *)
struct SearchHistoryView: View {
    
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    
    @State var iphoneWidth : CGFloat = UIScreen.main.bounds.width * 0.9
    @Binding var ipadWidth : CGFloat
    
    var body: some View {
            let key = "searchTextArray"
            let searchHistory = UserDefaults.standard.stringArray(forKey: key)!
            
            VStack(spacing:0) {
                Spacer()
                HStack {
                    ForEach(searchHistory, id: \.self) { search in
                        HStack {
                            Spacer()
                            Text(search)
                            Spacer()
                            
                        }
                        .onTapGesture {
                            calculateViewModel.searchText = search
                        }
                    }
                }
            }
            .padding()
            .frame(width : Constants.isPad() ? ipadWidth : iphoneWidth, height: 75 + 35)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 5)
            )
            .cornerRadius(15)
            .onChange(of: searchHistory) {
                Constants.myPrint(title: "searchHistory", content: searchHistory)
            }
        
        
        
    }
        
}



