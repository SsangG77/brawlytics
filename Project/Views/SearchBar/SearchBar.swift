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
//    @Binding var allBrawlersStandard: [BrawlerStandard]
    @Binding var clicked: Bool
    
#warning("RX 방식 변경을 위한 테스트")
    @EnvironmentObject var calculateViewModel: RxCalculateViewModel

    @EnvironmentObject var appState: AppState
    @ObservedObject var searchBarViewModel: SearchBarViewModel
    
    @State var iphoneWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    @State var ipadWidth: CGFloat = 0  // GeometryReader에서 사용할 값을 저장할 변수 추가
    
    // 다크 모드
    @Environment(\.colorScheme) var colorScheme
    
    // Ad
    @State private var adManager = InterstitialAdManager()

    var body: some View {
        
        GeometryReader { geo in
            
            let ipadWidth = geo.size.width * 0.7  // @State 대신 일반 변수로 선언
            
            ZStack(alignment: .top) {
                if showHistory {
                    SearchHistoryView(ipadWidth: $ipadWidth)
                        .environmentObject(searchBarViewModel)
                }
                
                VStack {
                    ZStack {
                        HStack {
                            TextField("유저 태그 입력", text: Binding(
                                get: { (try? searchBarViewModel.searchTextSubject.value()) ?? "" },
                                set: { searchBarViewModel.updateSearchText($0) }
                            ), onEditingChanged: { isEdit in
                                withAnimation {
                                    showHistory = isEdit
                                }
                            })
                            .padding(.horizontal, 10)
//                            .foregroundColor(.black) // 글자색 고정
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .frame(height: 65)
                            .background(colorScheme == .dark ? .black : .white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 10)
                            )
                            .cornerRadius(15)
                        }
                        
                        HStack {
                            Spacer() // 버튼을 오른쪽으로 이동
                            Button(action: {
                                
                                // 키보드 활성화 유무 체크
                                if UIApplication.shared.sendAction(
                                    #selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil
                                ) {
                                    //키보드 비활성화 시키기
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }

                                let text = (try? searchBarViewModel.searchTextSubject.value()) ?? ""
                                guard let text = try? searchBarViewModel.searchTextSubject.value(), !text.isEmpty else {
                                    return
                                }
                                
                                // AppState 값 초기화
                                appState.totalCoin = 0
                                appState.totalPP = 0
                                appState.totalCredit = 0
                                
                                clicked = false
                                calculateViewModel.isError = false
                                
                                // 검색 기록 저장
                                searchBarViewModel.triggerSearch()
                                showHistory = false
                                
                                adManager.onAdStart = {
                                    withAnimation {
                                        clicked = true
                                        calculateViewModel.isLoadingSubject.onNext(true)
                                    }
                                }
                               
                                adManager.onAdDismiss = {
                                    DispatchQueue.main.async {
                                        withAnimation {
//                                            clicked = true
//                                            calculateViewModel.isLoadingSubject.onNext(true)
                                            calculateViewModel.isLoadingSubject.onNext(false)
                                            calculateViewModel.getBrawlers(text)
                                        }
                                    }
                                }

                                      
                              if let rootVC = UIApplication.shared.connectedScenes
                                  .compactMap({ ($0 as? UIWindowScene)?.keyWindow})
                                  .first?.rootViewController {
                                  adManager.showAd(from: rootVC)
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
        .onAppear {
            Task {
                await adManager.loadAd()
            }
        }
        .onDisappear {
//            clicked = false
            showHistory = false
//            calculateViewModel.brawlers = []
            
//            appState.totalCoin = 0
//            appState.totalPP = 0
//            appState.totalCredit = 0
        }
    }
}
