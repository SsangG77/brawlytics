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
    var brawlerStandard: BrawlerStandard
    @Binding var brawler: Brawler?
    
    
    //view model
    @EnvironmentObject var viewModel: BrawlersViewModel
    @State var imageSize: CGFloat = 42
    
    var body: some View {
            HStack(spacing: -18) {
                
                SingleGearView(imageName: "SPEED", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "SPEED"), offset: true)
                SingleGearView(imageName: "HEALTH", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "HEALTH"), offset: false)
                SingleGearView(imageName: "DAMAGE", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "DAMAGE"), offset: true)
                SingleGearView(imageName: "VISION", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "VISION"), offset: false)
                SingleGearView(imageName: "SHIELD", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "SHIELD"), offset: true)
                SingleGearView(imageName: "GADGET COOLDOWN", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "GADGET COOLDOWN"), offset: false)
                
                
                //영웅 기어
                if brawlerStandard.epicGear == .reloadSpeed {
                    SingleGearView(imageName: "RELOAD SPEED", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "RELOAD SPEED"), offset: true)
                }
                

                if brawlerStandard.epicGear == .superCharge {
                    SingleGearView(imageName: "SUPER CHARGE", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "SUPER CHARGE"), offset: true)
                }
                

                if brawlerStandard.epicGear == .petPower {
                    SingleGearView(imageName: "PET POWER", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "PET POWER"), offset: true)
                }
                
                //신화기어 표시
                if let brawler = brawler, !brawler.name.isEmpty {
                    switch brawler.name {
                    case "TICK":
                        SingleGearView(
                            imageName: "THICC HEAD",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "THICC HEAD"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "GENE":
                        SingleGearView(
                            imageName: "TALK TO THE HAND",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "TALK TO THE HAND"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "CROW":
                        SingleGearView(
                            imageName: "ENDURING TOXIN",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "ENDURING TOXIN"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "SANDY":
                        SingleGearView(
                            imageName: "EXHAUSTING STORM",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "EXHAUSTING STORM"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "SPIKE":
                        SingleGearView(
                            imageName: "STICKY SPIKES",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "STICKY SPIKES"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "LEON":
                        SingleGearView(
                            imageName: "LINGERING SMOKE",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "LINGERING SMOKE"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "AMBER":
                        SingleGearView(
                            imageName: "STICKY OIL",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "STICKY OIL"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "EVE":
                        SingleGearView(
                            imageName: "QUADRUPLETS",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "QUADRUPLETS"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "PAM":
                        SingleGearView(
                            imageName: "SUPER TURRET",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "SUPER TURRET"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    case "MORTIS":
                        SingleGearView(
                            imageName: "BAT STORM",
                            withItem: viewModel.judgeGear(gears: brawler.gears, gear: "BAT STORM"),
                            offset: brawlerStandard.epicGear == .none
                        )
                        
                    default:
                        EmptyView()
                    }
                }

            }
            .frame(width: (parentWidth - 35) * 0.7, height: (parentWidth - 35) * 0.3, alignment: .center)
            .background(Color(hexString: "4C658D", opacity: 0.53))
            .cornerRadius(15)
    }
        
}
