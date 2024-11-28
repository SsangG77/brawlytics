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
    @State var default_arr = [1,1,1,1]
    
    @State var clicked = false
    @State private var isLoading: Bool = false

    
    var body: some View {
        VStack(spacing : 0) {
            
            SearchBar(brawlers_standard: $brawlers_standard, clicked: $clicked, isLoading: $isLoading)
                .environmentObject(calculateViewModel)
            
            ScrollView {
                if clicked {
                    if isLoading {
                        ForEach(0..<3) {_ in
                            BrawlerEmptyView()
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
//    } else {
//        // Fallback on earlier versions
//    }
//}


