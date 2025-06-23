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
            if vm.isPad {
                HStack {
                    backCard
                    Spacer()
                    frontCard
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
            if !vm.isPad {
                Spacer().frame(height: vm.cardFrontHeight)
            }
            backView
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
        case .win: return Color.lightRed
        case .lose: return Color.lightBlue
        case .user, .brawler: return Color.deepColor
        }
    }
    
    var backColor: Color {
        switch self {
        case .win: return Color.deepRed
        case .lose: return Color.deepBlue
        case .user, .brawler: return Color.lightColor
        }
    }
    
    var frontHeight: CGFloat {
        switch self {
            case .win, .lose: return 270
            case .user : return 100
            case .brawler : return 80
        }
    }
    
    var backHeight: CGFloat {
        switch self {
            case .win, .lose: return 330
            case .user: return 185
            case .brawler : return 160
        }
    }
}



#Preview {
    OverlapCardView(vm: OverlapCardViewModel(type: .user), frontView: {
        Text("front").foregroundStyle(.white)
        },
        backView: {
            Text("tst")
        }
    )
    
    Spacer()
        
}
