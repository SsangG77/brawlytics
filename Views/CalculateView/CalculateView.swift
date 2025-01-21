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
    
    @StateObject var calculateViewModel = CalculateViewModel()
    @StateObject var brawlersViewModel = BrawlersViewModel()
    
//    @State var brawlers_standard:[Brawler_standard] = []

    @State var tanker_brawlers_standard: [Brawler_standard] = []
    @State var assassin_brawlers_standard: [Brawler_standard] = []
    @State var supporter_brawlers_standard: [Brawler_standard] = []
    @State var damage_dealers_brawlers_standard: [Brawler_standard] = []
    @State var controller_brawlers_standard: [Brawler_standard] = []
    @State var marksmen_brawlers_standard: [Brawler_standard] = []
    @State var throw_brawlers_standard: [Brawler_standard] = []
    
    
    @State var clicked = false
    @State private var isLoading: Bool = false
    
    //total money icon size
    let iconSize: CGFloat = 20
    let fontSize: CGFloat = 20
    
    
    var body: some View {
        
        GeometryReader { geo in
            
            var width = Constants.isPad() ? geo.size.width * 0.3 - 10 : geo.size.width * 0.9
            
            
            VStack(spacing : 0) {
                
                
                calculateViewModel.DynamicStack(isPad: Constants.isPad()) {

                        SearchBar(
                            tanker_brawlers_standard: $tanker_brawlers_standard,
                            assassin_brawlers_standard: $assassin_brawlers_standard,
                            supporter_brawlers_standard: $supporter_brawlers_standard,
                            damage_dealers_brawlers_standard: $damage_dealers_brawlers_standard,
                            controller_brawlers_standard: $controller_brawlers_standard,
                            marksmen_brawlers_standard: $marksmen_brawlers_standard,
                            throw_brawlers_standard: $throw_brawlers_standard,
                            clicked: $clicked, isLoading: $isLoading)
                        .environmentObject(calculateViewModel)
                        .environmentObject(appState)
                        .zIndex(1)
                        
                        
                        MoneyBoxView()
                            .environmentObject(appState)
                    
                }
                
                
                ScrollView {
                    
                    
                    if !isLoading && clicked  {
                        ClassesTitleView(imageName: "tanker_icon", title: "탱커")
                            .padding(.top, 7)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            if clicked {
                                if isLoading {
                                    BrawlerEmptyView()
                                } else if tanker_brawlers_standard.isEmpty {
                                    Text("No Data Found") // 데이터가 없는 경우 표시
                                } else {
                                    ForEach($tanker_brawlers_standard, id: \.id) { brawler_st in
                                        BrawlerView(width: width, brawler_standard: brawler_st)
                                            .padding(5)
                                            .environmentObject(calculateViewModel)
                                            .environmentObject(appState)
                                    }
                                }
                            }
                            
                        }//--@LazyHStack
                        .scrollTargetLayout()
                        .frame(height: 280)
                        
                    }//--@ScrollView
                    .frame(height: 280)
                    .scrollTargetBehavior(.viewAligned)
//                    .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.1 / 2)
                    .contentMargins(.horizontal, geo.size.width * 0.1 / 2)
                    
                    
                    
                    
                    if !isLoading && clicked  {
                        ClassesTitleView(imageName: "assassin_icon", title: "어쌔신")
                            .padding(.top, 7)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            if clicked {
                                if isLoading {
                                    BrawlerEmptyView()
                                } else if assassin_brawlers_standard.isEmpty {
                                    Text("No Data Found") // 데이터가 없는 경우 표시
                                } else {
                                    ForEach($assassin_brawlers_standard, id: \.id) { brawler_st in
                                        BrawlerView(width: width, brawler_standard: brawler_st)
                                            .padding(5)
                                            .environmentObject(calculateViewModel)
                                            .environmentObject(appState)
                                    }
                                }
                            }
                            
                        }//--@LazyHStack
                        .scrollTargetLayout()
                        .frame(height: 280)
                        
                    }//--@ScrollView
                    .frame(height: 280)
                    .scrollTargetBehavior(.viewAligned)
//                    .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.1 / 2)
                    .contentMargins(.horizontal, geo.size.width * 0.1 / 2)
                    
                    
                    
                    
                    if !isLoading && clicked  {
                        ClassesTitleView(imageName: "supporter_icon", title: "서포터")
                            .padding(.top, 7)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            if clicked {
                                if isLoading {
                                    BrawlerEmptyView()
                                } else if supporter_brawlers_standard.isEmpty {
                                    Text("No Data Found") // 데이터가 없는 경우 표시
                                } else {
                                    ForEach($supporter_brawlers_standard, id: \.id) { brawler_st in
                                        BrawlerView(width: width, brawler_standard: brawler_st)
                                            .environmentObject(calculateViewModel)
                                            .environmentObject(appState)
                                    }
                                }
                            }
                            
                        }//--@LazyHStack
                        .scrollTargetLayout()
                        .frame(height: 280)
                        
                    }//--@ScrollView
                    .frame(height: 280)
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, geo.size.width * 0.1 / 2)
                    
                    
                    if !isLoading && clicked  {
                        ClassesTitleView(imageName: "controller_icon", title: "컨트롤러")
                            .padding(.top, 7)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            if clicked {
                                if isLoading {
                                    BrawlerEmptyView()
                                } else if controller_brawlers_standard.isEmpty {
                                    Text("No Data Found") // 데이터가 없는 경우 표시
                                } else {
                                    ForEach($controller_brawlers_standard, id: \.id) { brawler_st in
                                        BrawlerView(width: width, brawler_standard: brawler_st)
                                            .environmentObject(calculateViewModel)
                                            .environmentObject(appState)
                                    }
                                }
                            }
                            
                        }//--@LazyHStack
                        .scrollTargetLayout()
                        .frame(height: 280)
                        
                    }//--@ScrollView
                    .frame(height: 280)
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.1 / 2)
                    
                    if !isLoading && clicked  {
                        
                        ClassesTitleView(imageName: "damage_dealer_icon", title: "데미지 딜러")
                            .padding(.top, 7)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            if clicked {
                                if isLoading {
                                    BrawlerEmptyView()
                                } else if damage_dealers_brawlers_standard.isEmpty {
                                    Text("No Data Found") // 데이터가 없는 경우 표시
                                } else {
                                    ForEach($damage_dealers_brawlers_standard, id: \.id) { brawler_st in
                                        BrawlerView(width: width, brawler_standard: brawler_st)
                                            .environmentObject(calculateViewModel)
                                            .environmentObject(appState)
                                    }
                                }
                            }
                            
                        }//--@LazyHStack
                        .scrollTargetLayout()
                        .frame(height: 280)
                        
                    }//--@ScrollView
                    .frame(height: 280)
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, geo.size.width * 0.1 / 2)
                    
                    if !isLoading && clicked  {
                        
                        ClassesTitleView(imageName: "marksmen_icon", title: "저격수")
                            .padding(.top, 7)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            if clicked {
                                if isLoading {
                                    BrawlerEmptyView()
                                } else if marksmen_brawlers_standard.isEmpty {
                                    Text("No Data Found") // 데이터가 없는 경우 표시
                                } else {
                                    ForEach($marksmen_brawlers_standard, id: \.id) { brawler_st in
                                        BrawlerView(width: width, brawler_standard: brawler_st)
                                            .environmentObject(calculateViewModel)
                                            .environmentObject(appState)
                                    }
                                }
                            }
                            
                        }//--@LazyHStack
                        .scrollTargetLayout()
                        .frame(height: 280)
                        
                    }//--@ScrollView
                    .frame(height: 280)
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, geo.size.width * 0.1 / 2)
                    
                    if !isLoading && clicked {
                        
                        ClassesTitleView(imageName: "throw_icon", title: "투척수")
                            .padding(.top, 7)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            if clicked {
                                if isLoading {
                                    BrawlerEmptyView()
                                } else if throw_brawlers_standard.isEmpty {
                                    Text("No Data Found") // 데이터가 없는 경우 표시
                                } else {
                                    ForEach($throw_brawlers_standard, id: \.id) { brawler_st in
                                        BrawlerView(width: width, brawler_standard: brawler_st)
                                            .environmentObject(calculateViewModel)
                                            .environmentObject(appState)
                                    }
                                }
                            }
                            
                        }//--@LazyHStack
                        .scrollTargetLayout()
                        .frame(height: 280)
                        
                    }//--@ScrollView
                    .frame(height: 280)
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, geo.size.width * 0.1 / 2)
                    
                    
                }
//                .frame(height: UIScreen.main.bounds.height - 275)
                .frame(height: geo.size.height - 120)
                
                
                
                //============================================================
                
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
        }//geo
        .ignoresSafeArea(.keyboard)
        .background(Color(hexString: "37475F"))
        
        
    }
}


struct BrawlerEmptyView: View {
    //size setting
    var totalHeight: CGFloat = 260
    var brawlerHeight: CGFloat = 210
    @State var width: CGFloat = UIScreen.main.bounds.width * 0.9
    
    @State var opacity:Double = 1.0
    @State var imageSize : CGFloat = 33
    
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: width, height: totalHeight)
                .cornerRadius(20)
                .foregroundColor(Color(hexString: "576E90"))
                .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
            
            VStack {
                
                //브롤러 정보들
                VStack {
                    HStack(spacing: 10) {
                        VStack {
                            
                        }
                        .frame(width: (width - 35) * 0.3, height: (width - 35) * 0.3)
                        .background(Color(hexString: "4C658D", opacity: 0.53))
                        .cornerRadius(15)
                        .modifier(BlinkingAnimationModifier(shouldShow: true, opacity: opacity))
                            
                        VStack {
                            
                        }
                        .frame(width: (width - 35) * 0.7, height: (width - 35) * 0.3, alignment: .center)
                        .background(Color(hexString: "4C658D", opacity: 0.53))
                        .cornerRadius(15)
                        .modifier(BlinkingAnimationModifier(shouldShow: true, opacity: opacity))
                            
                    }
                    VStack {
                        
                    }
                    .frame(width: width - 25, height: 80)
                    .background(Color(hexString: "4C658D", opacity: 0.53))
                    .cornerRadius(15)
                    .modifier(BlinkingAnimationModifier(shouldShow: true, opacity: opacity))
                }
                .frame(width: width , height: brawlerHeight)
                .cornerRadius(20)
                .background(Color(hexString: "6D8CB9"))
                .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
                
                //해당 브롤러 재화 표시 부분
                HStack {
                    
                    Spacer()
                    
                    HStack {
                        Image("pp")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        
                        Text(String(0))
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image("coin")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        
                        Text(String(0))
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image("credit")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        
                        Text(String(0))
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    
                    
                    
                }
                .frame(width: width)
                .padding(.bottom, 14)
                .frame(height: totalHeight - brawlerHeight)
            }//VStack
            .frame(height: totalHeight)
            
            
            
        }//ZStack
        .onAppear(perform: {
            withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                self.opacity = opacity == 0.4 ? 0.8 : 0.4
            }
        })
        
        
    }
}



//#Preview {
//    if #available(iOS 17.0, *) {
//        CalculateView()
//            .environmentObject(AppState())
//    } else {
//        // Fallback on earlier versions
//    }
//}

