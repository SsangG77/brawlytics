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
    @State var default_arr = [
        Brawler_standard(name: "8-BIT", first_gadget: "CHEAT CARTRIDGE", second_gadget: "EXTRA CREDITS", first_starPower: "BOOSTED BOOSTER", second_starPower: "PLUGGED IN", hypercharge: "AIMBOT")
    ]
    
    @State var clicked = false
    @State private var isLoading: Bool = false

    
    var body: some View {
        VStack(spacing : 0) {
            
            SearchBar(brawlers_standard: $brawlers_standard, clicked: $clicked, isLoading: $isLoading)
                .environmentObject(calculateViewModel)
            
            ScrollView {
                if clicked {
                    if isLoading {
//                        Text("Loading...") // 로딩 중인 상태 표시
                        ForEach($default_arr, id: \.id) { brawler_st in
                            BrawlerView(brawler_standard: brawler_st)
                                .environmentObject(calculateViewModel)
                                .padding()
                        }
                    } else if brawlers_standard.isEmpty {
                        Text("No Data Found") // 데이터가 없는 경우 표시
                    } else {
                        ForEach($brawlers_standard, id: \.id) { brawler_st in
                            BrawlerView(brawler_standard: brawler_st)
                                .environmentObject(calculateViewModel)
                                .padding()
                        }
                    }
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


