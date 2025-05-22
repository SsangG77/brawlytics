//
//  MoneyBoxView.swift
//  Brawlytics
//
//  Created by 차상진 on 12/22/24.
//

import SwiftUI

struct MoneyBoxView: View {
    
    
    @EnvironmentObject var appState: AppState
    
    //size
    @State var width: CGFloat = UIScreen.main.bounds.width * 0.9
    
    @State var iphoneHeight: CGFloat = 110
    @State var ipadHeight:CGFloat = 65
    
    //total money icon size
    let iconSize: CGFloat = 20
    let fontSize: CGFloat = 20
    
    var body: some View {
        
        GeometryReader { geo in
            
            @State var ipadWidth = geo.size.width * 0.9
            
            ZStack {
                Rectangle()
                    .frame(width: Constants.isPad() ? ipadWidth : width, height: Constants.isPad() ? ipadHeight : iphoneHeight)
                    .cornerRadius(20)
                    .foregroundColor(Color(hexString: "576E90"))
                    .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
                
                VStack {
                    
                    if !Constants.isPad() {
                        Spacer()
                    }
                    
                    HStack {
                        HStack {
                            Image("coin")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                            
                            Text(String(appState.totalCoin))
                                .font(.system(size: fontSize))
                                .bold()
                            
                        }//HStack
//                        .frame(minWidth: width/3.5)
                        .frame(minWidth: Constants.isPad() ? ipadWidth/3.5 : width/3.5)
                        
                        HStack {
                            Image("pp")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                            
                            Text(String(appState.totalPP))
                                .font(.system(size: fontSize))
                                .bold()
                            
                        }//HStack
//                        .frame(minWidth: width/3.5)
                        .frame(minWidth: Constants.isPad() ? ipadWidth/3.5 : width/3.5)
                        
                        
                        HStack {
                            Image("credit")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                            
                            Text(String(appState.totalCredit))
                                .font(.system(size: fontSize))
                                .bold()
                            
                        }//HStack
//                        .frame(minWidth: width/3.5)
                        .frame(minWidth: Constants.isPad() ? ipadWidth/3.5 : width/3.5)
                        
                        
                    }//HStack
                    .frame(width: Constants.isPad() ? ipadWidth : width)
                    .padding(.bottom, Constants.isPad() ? 0 : 15)
                    
                }
                .frame(height: Constants.isPad() ? ipadHeight :  iphoneHeight)
            }
            .padding([.leading, .trailing])
        }
        
        
      
    }
}

