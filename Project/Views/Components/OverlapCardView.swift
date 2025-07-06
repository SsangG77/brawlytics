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
            if vm.type == .user {
                
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
            if [.user, .brawler, .graph].contains(vm.type) {
                Spacer().frame(height: vm.cardFrontHeight)
            }

            backView
            
            if [.win, .lose, .soloShowdown, .duoShowdown, .trioShowdown].contains(vm.type) {
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
