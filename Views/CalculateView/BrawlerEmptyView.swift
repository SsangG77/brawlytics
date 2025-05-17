//
//  BrawlerEmptyView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/18/25.
//

import Foundation
import SwiftUI


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

