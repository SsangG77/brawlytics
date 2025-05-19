//
//  SearchBar.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import SwiftUI


protocol SearchHistoryRepository {
    func saveSearchText(_ searchText:String)
    func getSearchHistory() -> [String]
}

class SearchHistoryRepositoryImpl: SearchHistoryRepository {
    @AppStorage("searchString") var searchString: [String] = []

    func saveSearchText(_ searchText:String) {
        if !searchString.contains(searchText) {
            if searchString.count >= 3 {
                searchString.removeFirst()
                searchString.append(searchText)
            } else {
                searchString.append(searchText)
            }
        }
    }

    func getSearchHistory() -> [String] {
        return searchString
    }
}

protocol SearchBarUseCase {
    func saveSearchText(_ searchText: String)
    func getSearchHistory() -> [String]
}

class SearchBarUseCaseImpl: SearchBarUseCase {
    
    private let historyRepository : SearchHistoryRepository
    
    init(historyRepository: SearchHistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func saveSearchText(_ searchText: String) {
        historyRepository.saveSearchText(searchText)
    }
    
    func getSearchHistory() -> [String] {
        return historyRepository.getSearchHistory()
    }
}


class SearchBarViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchHistory: [String] = []
    
    private let historyRepository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.historyRepository = repository
    }
    
    
    func saveSearchText(_ searchText: String) {
        historyRepository.saveSearchText(searchText)
    }
    
    func getSearchHistory() -> [String] {
        return historyRepository.getSearchHistory()
    }
    
    
}

@available(iOS 17.0, *)
struct SearchBar: View {
    @State var showHistory:Bool = false
    
//    @Binding var tanker_brawlers_standard: [BrawlerStandard]
//    @Binding var assassin_brawlers_standard: [BrawlerStandard]
//    @Binding var supporter_brawlers_standard: [BrawlerStandard]
//    @Binding var damage_dealers_brawlers_standard: [BrawlerStandard]
//    @Binding var controller_brawlers_standard: [BrawlerStandard]
//    @Binding var marksmen_brawlers_standard: [BrawlerStandard]
//    @Binding var throw_brawlers_standard: [BrawlerStandard]
    
    @Binding var allBrawlersStandard: [BrawlerStandard]
    
    @Binding var clicked: Bool
    @Binding var isLoading: Bool
    
    
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    @ObservedObject var searchBarViewModel: SearchBarViewModel
    
    @EnvironmentObject var appState: AppState
    
    @StateObject var brawlersViewModel: BrawlersViewModel
    @StateObject var service: BrawlersService
    
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
//                                            tanker_brawlers_standard = brawlersViewModel.tanker_brawlers_standard
//                                            assassin_brawlers_standard = brawlersViewModel.assassin_brawlers_standard
//                                            supporter_brawlers_standard = brawlersViewModel.supporter_brawlers_standard
//                                            controller_brawlers_standard = brawlersViewModel.controller_brawlers_standard
//                                            damage_dealers_brawlers_standard = brawlersViewModel.damage_dealers_brawlers_standard
//                                            marksmen_brawlers_standard = brawlersViewModel.marksmen_brawlers_standard
//                                            throw_brawlers_standard = brawlersViewModel.throw_brawlers_standard
                                            
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
//            tanker_brawlers_standard = []
//            assassin_brawlers_standard = []
//            supporter_brawlers_standard = []
//            controller_brawlers_standard = []
//            damage_dealers_brawlers_standard = []
//            marksmen_brawlers_standard = []
//            throw_brawlers_standard = []
            allBrawlersStandard = []
            calculateViewModel.brawlers = []
            
            appState.totalCoin = 0
            appState.totalPP = 0
            appState.totalCredit = 0
        }
    }
}



@available(iOS 17.0, *)
struct SearchHistoryView: View {
    
//    @EnvironmentObject var calculateViewModel: CalculateViewModel
    @EnvironmentObject var searchBarViewModel : SearchBarViewModel
    
    @State var iphoneWidth : CGFloat = UIScreen.main.bounds.width * 0.9
    @Binding var ipadWidth : CGFloat
    
    
    @AppStorage("searchString") var searchString: [String] = []
    
    var body: some View {
            VStack(spacing:0) {
                Spacer()
                HStack {
                    ForEach(searchString, id: \.self) { search in
                        HStack {
                            Spacer()
                            Text(search)
                            Spacer()
                        }
                        .onTapGesture {
                            searchBarViewModel.searchText = search
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
    }
}



