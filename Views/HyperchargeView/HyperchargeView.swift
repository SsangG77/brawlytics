//
//  HyperchargeView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/19/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct HyperchargeView: View {
    
    @StateObject var viewModel:BrawlersViewModel = BrawlersViewModel()
    
    
    var body: some View {
        
        
        
        if Constants.isPad() {
            
            GeometryReader { geo in
                
                var width = geo.size.width / 3.5
                
                
                
                ScrollView {
                    HStack(alignment: .top) {
                        
                        
                        VStack {
                            ForEach(0..<$viewModel.all_brawlers_standard.count) { i in
                                if i % 3 == 0 {
                                    if $viewModel.all_brawlers_standard[i].hypercharge.wrappedValue != "" {
                                        SingleHyperchargeView(width: width, hyperchargeName: $viewModel.all_brawlers_standard[i].hypercharge, brawlerName: $viewModel.all_brawlers_standard[i].name)
                                            
                                    }
                                        
                                }
                            }
                        }
                        .padding(10)
                        .frame(width: width + 30)
                        
                        VStack {
                            ForEach(0..<$viewModel.all_brawlers_standard.count) { i in
                                if i % 3 == 1 {
                                    if $viewModel.all_brawlers_standard[i].hypercharge.wrappedValue != "" {
                                        SingleHyperchargeView(width: width, hyperchargeName: $viewModel.all_brawlers_standard[i].hypercharge, brawlerName: $viewModel.all_brawlers_standard[i].name)
                                            
                                    }
                                        
                                }
                            }
                        }
                        .padding(10)
                        .frame(width: width + 30)
                        
                        VStack {
                            ForEach(0..<$viewModel.all_brawlers_standard.count) { i in
                                if i % 3 == 2 {
                                    if $viewModel.all_brawlers_standard[i].hypercharge.wrappedValue != "" {
                                        SingleHyperchargeView(width: width, hyperchargeName: $viewModel.all_brawlers_standard[i].hypercharge, brawlerName: $viewModel.all_brawlers_standard[i].name)
                                            
                                    }
                                        
                                }
                            }
                        }
                        .padding(10)
                        .frame(width: width + 30)
                        
                        
                        
                        
                        
                        
                        
                    }
                    .frame(width: geo.size.width , height: .infinity, alignment: .center)
                }
//                .background(Color(hexString: "37475F"))
                
                
            }
            .background(Color(hexString: "37475F"))
            
            
            
        } else {
            
            ScrollView {
                ForEach($viewModel.all_brawlers_standard, id:\.id) { brawler_st in
                    
                    if brawler_st.hypercharge.wrappedValue != "" {
                        SingleHyperchargeView(width: UIScreen.main.bounds.width * 0.9, hyperchargeName: brawler_st.hypercharge, brawlerName: brawler_st.name)
                            .padding([.top, .bottom], 7)
                    }
                    
                }
                
            }
            .frame(width: UIScreen.main.bounds.width, height: .infinity)
            .background(Color(hexString: "37475F"))
        }
        
        
        
        
    }
}




@available(iOS 17.0, *)
struct SingleHyperchargeView: View {
    
    var totalHeight: CGFloat = 60
//    @State var width: CGFloat = UIScreen.main.bounds.width * 0.9
    
    @State private var isOn = false
    @StateObject var viewModel = BrawlersViewModel()
    
    
    //Binding
    var width:CGFloat
    @Binding var hyperchargeName:String
    @Binding var brawlerName:String
    
    var body: some View {
        ZStack {
            
            HStack {
                Spacer()
                
                Image(brawlerName)
                    .resizable()
                    .scaleEffect(x: -1, y: 1) // X축을 -1로 설정하여 좌우 반전
                    .frame(width: 130, height: 100)
                
            }
            .frame(width:width, height: 64)
            .cornerRadius(15)
            .clipped()
//            .padding(.trailing, 20)
            
            
            
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(hexString: "FFFFFF", opacity: 0.5), location: 0),
                        .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: .trailing,
                    endPoint: .leading
                ))
                .frame(width: width, height: totalHeight)
                .cornerRadius(15)
                .foregroundColor(Color(hexString: "576E90"))
                .roundedCornerWithBorder(lineWidth: 5, borderColor: isOn ? .black : .white, radius: 15, corners: [.allCorners])
                
            
            
                
            
            
            
            
            
            
            HStack {
                Image(systemName: isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(isOn ? Color(UIColor.systemBlue) : Color.secondary)
                    .onTapGesture {
                        self.isOn.toggle()
                        //체크되어있으면 배열에서 삭제하고 체크되어있지 않으면 배열에 추가
                        if isOn {
                            viewModel.addHyperchargeArray(hyperchargeName)
                        } else {
                            viewModel.removeHyperchargeArray(hyperchargeName)
                        }
                
                    }
                
                Image(hyperchargeName)
                    .resizable()
                    .frame(width: 33, height: 40)
                
                Text(hyperchargeName)
                
                Spacer()
                
                
            }//VStack
            .padding(.leading, 30)
            .clipped()
            
        }
        .clipped()
        .onAppear {
            isOn = viewModel.judgeHypercharge(hyperchargeName)
        }
    }
}

//#Preview {
//    HyperchargeView()
//}
