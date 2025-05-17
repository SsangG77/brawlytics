//
//  ClassesTitleView.swift
//  Brawlytics
//
//  Created by 차상진 on 12/14/24.
//

import SwiftUI

struct ClassesTitleView: View {
    
    @State var width: CGFloat = UIScreen.main.bounds.width * 0.9
    
    var imageName: String
    var title:String
    
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
            
            StrokeText(text: title, width: 1.5)
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .bold))
            
            Rectangle()
                .frame(height: 3)
                .cornerRadius(15)
            
        }
        .frame(width: width)
        .padding([.top, .bottom], 3)
    }
}


struct StrokeText: View {
    let text: String
    let width: CGFloat

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(.black)
            Text(text)
        }
    }
}
