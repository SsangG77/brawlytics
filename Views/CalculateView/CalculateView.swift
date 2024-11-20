//
//  CalculateView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import SwiftUI


@available(iOS 17.0, *)
struct CalculateView: View {
    
    @StateObject var calculateViewModel = CalculateViewModel()
    @StateObject var brawlersViewModel = BrawlersViewModel()
    
    @State var brawlers_standard:[Brawler_standard] = []
    
    var body: some View {
        VStack(spacing : 0) {
            
            SearchBar(brawlers_standard: $brawlers_standard)
                .environmentObject(calculateViewModel)
            
            ScrollView {
                ForEach($brawlers_standard, id:\.id) { brawler_st in
                    BrawlerView(brawler_standard: brawler_st, myBrawlers: $calculateViewModel.brawlers)
                        .padding()
                }

            }
            .contentMargins(.top, 20)
            .frame(width: UIScreen.main.bounds.width * 1.2, height: .infinity)
            
            
            
            
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        .frame(width: UIScreen.main.bounds.width, height: .infinity)
        .background(Color(hexString: "37475F"))
    }
}

//#Preview {
//    if #available(iOS 17.0, *) {
//        CalculateView()
//    } else {
//        // Fallback on earlier versions
//    }
//}


