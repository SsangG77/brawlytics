//
//  BrawlerView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/4/24.
//

import SwiftUI





//브롤러 한개당 정보 모음
@available(iOS 17.0, *)
struct BrawlerView: View {
    
    
    
    //size setting
    var totalHeight: CGFloat = 260
    var brawlerHeight: CGFloat = 210
//    @State var width: CGFloat = UIScreen.main.bounds.width * 0.9
    
    
    //
    @State var brawler: Brawler?
    @State var opacity:Double = 1.0
    
    //바인딩된 값
    var width: CGFloat
    @Binding var brawler_standard: Brawler_standard
    
    
    //view model
    @StateObject var brawlersViewModel = BrawlersViewModel()
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    
    @EnvironmentObject var appState: AppState
    
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
                            BrawlerProfileView(parentWidth: width, brawler_st: $brawler_standard, brawler: $brawler)
                                .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))
                            
                            GearView(parentWidth: width, brawler: $brawler)
                                .environmentObject(brawlersViewModel)
                                .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))
                            
                        }
                        PowerView(parentWidth: width, brawler_standard: $brawler_standard, brawler: $brawler)
                            .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))
                    }
                    .frame(width: width , height: brawlerHeight)
                    .cornerRadius(20)
                    .background(Color(hexString: "6D8CB9"))
                    .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
                    .overlay {
                        if brawler?.name == "" {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color(hexString: "000000", opacity: 0.7))
                        }
                    }
                    
                    //해당 브롤러 재화 표시 부분
                    MoneyCountView(parentWidth: width, brawler: $brawler, brawler_standard: $brawler_standard)
                        .environmentObject(appState)
                        .frame(height: totalHeight - brawlerHeight)
                }//VStack
                .frame(height: totalHeight)
                
                
                
            }//ZStack
            .onChange(of: calculateViewModel.brawlers) {
                withAnimation {
                    
                    if brawler_standard != nil {
                        brawler = calculateViewModel.findMyBrawler(brawlerName: brawler_standard.name)
                        
                    }
                    
                }
            }
            .onAppear(perform: {
                withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: true)) {
                    self.opacity = opacity == 0.4 ? 0.8 : 0.4
                }
            })
        
        
    }
}








struct BrawlerProfileView: View {
    
    var parentWidth: CGFloat
    @Binding var brawler_st: Brawler_standard
    @Binding var brawler: Brawler?
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            // 배경 이미지
            Image(brawler_st.name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (parentWidth - 35) * 0.3, height: (parentWidth - 35) * 0.3) // 이미지 크기 설정
                .clipped()
            
            // 레벨 표시를 위한 ZStack
            ZStack {
                Image("level")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text(String(brawler?.name ?? "" == "" ? 0 : brawler?.power ?? 0))
                    .foregroundColor(.white)
                    .fontWeight(.black)
            }
            .offset(x: 1, y: 0) // 이미지의 왼쪽 상단에 고정 위치 지정
        }
        .frame(width: (parentWidth - 35) * 0.3, height: (parentWidth - 35) * 0.3)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)


    }
}






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
                if viewModel.reload_speed_gear_brawlers.contains(brawler?.name ?? " ") {
                    SingleGearView(imageName: "RELOAD SPEED", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "RELOAD SPEED"), offset: true)
                }
                
                if viewModel.super_charge_gear_brawlers.contains(brawler?.name ?? " ") {
                    SingleGearView(imageName: "SUPER CHARGE", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "SUPER CHARGE"), offset: true)
                }
                
                if viewModel.pet_power_gear_brawlers.contains(brawler?.name ?? " ") {
                    SingleGearView(imageName: "PET POWER", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "PET POWER"), offset: true)
                }
                
                
                let gearBrawlersSet = Set(viewModel.reload_speed_gear_brawlers)
                    .union(viewModel.super_charge_gear_brawlers)
                    .union(viewModel.pet_power_gear_brawlers)
                
                
                //신화기어 표시
                switch brawler?.name ?? "" {
                case "TICK":
                    SingleGearView(
                        imageName: "THICC HEAD",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "THICC HEAD"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "GENE":
                    SingleGearView(
                        imageName: "TALK TO THE HAND",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "TALK TO THE HAND"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "CROW":
                    SingleGearView(
                        imageName: "ENDURING TOXIN",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "ENDURING TOXIN"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "SANDY":
                    SingleGearView(
                        imageName: "EXHAUSTING STORM",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "EXHAUSTING STORM"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "SPIKE":
                    SingleGearView(
                        imageName: "STICKY SPIKES",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "STICKY SPIKES"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "LEON":
                    SingleGearView(
                        imageName: "LINGERING SMOKE",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "LINGERING SMOKE"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "AMBER":
                    SingleGearView(
                        imageName: "STICKY OIL",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "STICKY OIL"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "EVE":
                    SingleGearView(
                        imageName: "QUADRUPLETS",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "QUADRUPLETS"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "PAM":
                    SingleGearView(
                        imageName: "SUPER TURRET",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "SUPER TURRET"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                    
                case "MORTIS":
                    SingleGearView(
                        imageName: "BAT STORM",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "BAT STORM"),
                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                    )
                
                    
                default:
                    EmptyView() // 해당하지 않는 경우 (필요하면 대체)
                }

            }
            .frame(width: (parentWidth - 35) * 0.7, height: (parentWidth - 35) * 0.3, alignment: .center)
            .background(Color(hexString: "4C658D", opacity: 0.53))
            .cornerRadius(15)
    }
        
}





struct PowerView: View {
    
    @State var imageSize: CGFloat = 50
    
    //Binding
    var parentWidth: CGFloat
    @Binding var brawler_standard: Brawler_standard
    @Binding var brawler: Brawler?
    
    
    //viewModel
    @StateObject var viewModel: BrawlersViewModel = BrawlersViewModel()
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(brawler_standard.first_gadget)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawler_standard.first_gadget) ? 1 : 0)
                .colorMultiply(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawler_standard.first_gadget) ? Color.white : Color(hexString: "585858"))
            
            Image(brawler_standard.second_gadget)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawler_standard.second_gadget) ? 1 : 0)
                .colorMultiply(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawler_standard.second_gadget) ? Color.white : Color(hexString: "585858"))
            
            
            Image(brawler_standard.first_starPower)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawler_standard.first_starPower) ? 1 : 0)
                .colorMultiply(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawler_standard.first_starPower) ? Color.white : Color(hexString: "585858"))
            
            Image(brawler_standard.second_starPower)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawler_standard.second_starPower) ? 1 : 0)
                .colorMultiply(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawler_standard.second_starPower) ? Color.white : Color(hexString: "585858"))
            
            
            Image(brawler_standard.hypercharge)
                .resizable()
                .frame(width: imageSize - 10, height: imageSize)
                .saturation(viewModel.judgeHypercharge(brawler_standard.hypercharge) ? 1 : 0)
                .colorMultiply(viewModel.judgeHypercharge(brawler_standard.hypercharge) ? Color.white : Color(hexString: "585858"))
            
            
            
        }
        .frame(width: parentWidth - 25, height: 80)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)
        
    }
}





struct MoneyCountView: View {
    
    var parentWidth: CGFloat
    @Binding var brawler: Brawler?
    @Binding var brawler_standard: Brawler_standard
    
    @State var ppCount = -1
    @State var coinCount = -1
    @State var creditCount = -1
    @EnvironmentObject var appState: AppState
    
    @State var imageSize : CGFloat = 33
    
    @StateObject var brawlersViewModel: BrawlersViewModel = BrawlersViewModel()
    
    var body: some View {
        HStack {
            
            Spacer()
            
            HStack {
                Image("pp")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(ppCount))
                    .font(.title2)
            }
            
            Spacer()
            
            HStack {
                Image("coin")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(coinCount))
                    .font(.title2)
            }
            
            Spacer()
            
            HStack {
                Image("credit")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(String(creditCount))
                    .font(.title2)
            }
            
            Spacer()
            
            
            
            
        }
        .frame(width: parentWidth)
        .padding(.bottom, 14)
        .onChange(of: brawler) { newValue in
            if newValue != nil {
                ppCount = brawlersViewModel.calculatePP(brawler: brawler, brawler_standard: brawler_standard)
                creditCount = brawlersViewModel.calculateCredit(brawler: brawler, brawler_standard: brawler_standard)
                coinCount = brawlersViewModel.calculateCoin(brawler: brawler, brawler_standard: brawler_standard)
//
                appState.totalPP += brawlersViewModel.calculatePP(brawler: brawler, brawler_standard: brawler_standard)
                appState.totalCredit += brawlersViewModel.calculateCredit(brawler: brawler, brawler_standard: brawler_standard)
                appState.totalCoin += brawlersViewModel.calculateCoin(brawler: brawler, brawler_standard: brawler_standard)
                
            }
        }
        .onAppear {
        }
    }
}










//#Preview {
//    BrawlerProfileView()
//}
