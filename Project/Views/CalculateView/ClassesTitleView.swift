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

class ClassesTitleViewModel: ObservableObject {
    func getClassTitle(role: Role) -> String {
        switch role {
        case .tanker:
            return "탱커"
        case .assassin:
            return "어쌔신"
        case .supporter:
            return "서포터"
        case .controller:
            return "컨트롤러"
        case .damageDealer:
            return "데미지 딜러"
        case .marksmen:
            return "저격수"
        case .thrower:
            return "투척수"
        }
    }
    
    func getImageName(role: Role) -> String {
        switch role {
        case .tanker:
            return "tanker_icon"
        case .assassin:
            return "assassin_icon"
        case .supporter:
            return "supporter_icon"
        case .controller:
            return "controller_icon"
        case .damageDealer:
            return "damage_dealer_icon"
        case .marksmen:
            return "marksmen_icon"
        case .thrower:
            return "throw_icon"
        }
    }
}
