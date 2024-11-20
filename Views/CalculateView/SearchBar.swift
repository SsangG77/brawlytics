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
    
    @Binding var brawlers_standard: [Brawler_standard]
    
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    
    @StateObject var brawlersViewModel = BrawlersViewModel()

    var body: some View {
        
        
        ZStack(alignment: .top) {
            if showHistory {
                SearchHistoryView()
                    .padding(7)
                
            }
            
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
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 10)
                    )
                    .cornerRadius(15)
                }
                .ignoresSafeArea(.keyboard, edges: .all)
                
                HStack {
                    Spacer() // 버튼을 오른쪽으로 이동
                    Button(action: {
                        showHistory = false
//                        calculateViewModel.getBrawlers {
//                            brawlers_standard = brawlersViewModel.brawlers_standard
//                        }
                        calculateViewModel.getBrawlers()
                        brawlers_standard = brawlersViewModel.brawlers_standard
                        
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
            .ignoresSafeArea(.keyboard, edges: .all)
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        .padding()
        
        
        
        
        
    }
}



@available(iOS 17.0, *)
struct SearchHistoryView: View {
    
    @State var searchHistory:[String] = ["aaaa", "bdddd", "ccccc"]
    
    var body: some View {
        VStack(spacing:0) {
            Spacer()
            HStack {
                ForEach(searchHistory, id: \.self) { search in
                    Spacer()
                    Text(search)
                    Spacer()
                }
            }
        }
        .padding()
        .frame(height: 65 + 35)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 5)
        )
        .cornerRadius(15)
        
        
    }
}



