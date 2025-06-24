//
//  OverlapCardView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI


struct OverlapCardView<Front: View, Back: View>: View {
    
    
    // View Model
    let vm: OverlapCardViewModel
    let frontView: Front
    let backView: Back
    
    init(
        vm: OverlapCardViewModel,
        @ViewBuilder frontView: () -> Front,
        @ViewBuilder backView: () -> Back
    ) {
        self.vm = vm
        self.frontView = frontView()
        self.backView = backView()
    }
    
    
    var body: some View {
        
        Group {
            if vm.type == .user || vm.type == .brawler {
                
                if vm.isPad {
                    HStack {
                        backCard
                        Spacer()
                        frontCard
                    }
                }  else {
                    ZStack(alignment: vm.alignment) {
                        backCard
                        frontCard
                    }
                }
                
            } else {
                ZStack(alignment: vm.alignment) {
                    backCard
                    frontCard
                }
            }
        }
        .padding()
    }
    
    private var backCard: some View {
        VStack {
            if vm.type == .user || vm.type == .brawler {
                Spacer().frame(height: vm.cardFrontHeight)
            }
            backView
            
            if vm.type == .lose || vm.type == .win {
                Spacer().frame(height: vm.cardFrontHeight)
            }
        }
        .frame(width: vm.cardWidth, height: vm.cardBackHeight)
        .roundedCornerWithBorder(
            backgroundColor: vm.backColor,
            radius: vm.cardRadius
        )
    }
    
    private var frontCard: some View {
        VStack {
            frontView
        }
        .frame(width: vm.cardWidth, height: vm.cardFrontHeight)
        .roundedCornerWithBorder(
            backgroundColor: vm.frontColor,
            radius: vm.cardRadius
        )
    }
}

//MARK: - CardType
enum CardType {
    case win, lose, user, brawler
    
    var frontColor: Color {
        switch self {
        case .win: return Color.lightBlue
        case .lose: return Color.lightRed
        case .user, .brawler: return Color.deepColor
        }
    }
    
    var backColor: Color {
        switch self {
        case .win: return Color.deepBlue
        case .lose: return Color.deepRed
        case .user, .brawler: return Color.lightColor
        }
    }
    
    var frontHeight: CGFloat {
        switch self {
            case .win, .lose: return 300
            case .user : return 100
            case .brawler : return 70
        }
    }
    
    var backHeight: CGFloat {
        switch self {
            case .win, .lose: return /*360*/ frontHeight + 60
            case .user: return 185
            case .brawler : return 170
        }
    }
    
    var fontColor: Color {
        switch self {
        case .win : return Color(hexString: "8684FF")
        case .lose : return Color(hexString: "FF8080")
        default: return Color.white
        }
    }
    
}



#Preview {
    OverlapCardView(vm: OverlapCardViewModel(type: .lose), frontView: {
        Text("front").foregroundStyle(.white)
        },
        backView: {
            Text("tst")
        }
    )
    
    Spacer()
        
}
