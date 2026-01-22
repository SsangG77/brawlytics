//
//  GearView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import SwiftUI


struct SingleGearView: View {
    
    var imageName:String
    var withItem: Bool
    var offset: Bool
    var imageSize: CGFloat = 42
    
    var body: some View {
        Image(imageName)
            .resizable()
            .saturation(withItem ? 1 : 0)
            .colorMultiply(withItem ? Color.white : Color(hexString: "585858"))
            .frame(width: imageSize, height: imageSize)
            .offset(x: offset ? -2 : -3, y: offset ? -17 : 17)
    }
}




struct GearView: View {
    var parentWidth: CGFloat
    @Binding var brawlerDetail: BrawlerDetail


    //view model
    @EnvironmentObject var viewModel: BrawlersViewModel
    @State var imageSize: CGFloat = 42

    // BrawlerDetail.gears에서 소유 여부 확인
    private func hasGear(_ gearName: String) -> Bool {
        return brawlerDetail.gears.first(where: { $0.name == gearName })?.owned ?? false
    }

    var body: some View {
            HStack(spacing: -18) {

                SingleGearView(imageName: "SPEED", withItem: hasGear("speed"), offset: true)
                SingleGearView(imageName: "HEALTH", withItem: hasGear("health"), offset: false)
                SingleGearView(imageName: "DAMAGE", withItem: hasGear("damage"), offset: true)
                SingleGearView(imageName: "VISION", withItem: hasGear("vision"), offset: false)
                SingleGearView(imageName: "SHIELD", withItem: hasGear("shield"), offset: true)
                SingleGearView(imageName: "GADGET COOLDOWN", withItem: hasGear("gadgetCooldown"), offset: false)

            }
            .frame(width: (parentWidth - 35) * 0.7, height: (parentWidth - 35) * 0.3, alignment: .center)
            .background(Color(hexString: "4C658D", opacity: 0.53))
            .cornerRadius(15)
    }
        
}
