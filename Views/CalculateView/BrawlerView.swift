//
//  BrawlerView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/4/24.
//

import SwiftUI





//MARK: - BrawlerView
//브롤러 한개당 정보 모음
@available(iOS 17.0, *)
struct BrawlerView: View {
    
    // size setting
    var totalHeight: CGFloat = 260
    var brawlerHeight: CGFloat = 210

    @State var brawler: Brawler?
    @State var opacity: Double = 1.0

    var width: CGFloat
    var brawlerStandard: BrawlerStandard

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var calculateViewModel: CalculateViewModel
    
    let brawlersViewModel: BrawlersViewModel = BrawlersViewModel()
    let service = BrawlersService()
    
    init(width: CGFloat, brawlerStandard: BrawlerStandard) {
        self.width = width
        self.brawlerStandard = brawlerStandard
    }
    
    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
        .onAppear {
            withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: true)) {
                opacity = opacity == 0.4 ? 0.8 : 0.4
            }
        }
        .onChange(of: calculateViewModel.brawlers) {
            withAnimation {
                brawler = calculateViewModel.findMyBrawler(brawlerName: brawlerStandard.name)
            }
        }
    }
    
    private var backgroundView: some View {
        Rectangle()
            .frame(width: width, height: totalHeight)
            .cornerRadius(20)
            .foregroundColor(Color(hexString: "576E90"))
            .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
    }

    private var contentView: some View {
        VStack(spacing: 0) {
            profileBlock
            moneyBlock
        }
        .frame(height: totalHeight)
    }

    private var profileBlock: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                BrawlerProfileView(parentWidth: width, brawler_st: brawlerStandard, brawler: $brawler)
                    .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))

                GearView(parentWidth: width, brawlerStandard: brawlerStandard, brawler: $brawler)
                    .environmentObject(brawlersViewModel)
                    .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))
            }

            PowerView(parentWidth: width, brawlerStandard: brawlerStandard, brawler: $brawler)
                .modifier(BlinkingAnimationModifier(shouldShow: brawler == nil, opacity: opacity))
        }
        .frame(width: width, height: brawlerHeight)
        .background(Color(hexString: "6D8CB9"))
        .cornerRadius(20)
        .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 20, corners: [.allCorners])
        .overlay {
            if brawler?.name == "" {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(hexString: "000000", opacity: 0.7))
            }
        }
    }

    private var moneyBlock: some View {
        MoneyCountView(parentWidth: width, brawler: $brawler, brawlerStandard: brawlerStandard)
            .environmentObject(appState)
            .frame(height: totalHeight - brawlerHeight)
    }
}









//MARK: - BrawlerProfileView
struct BrawlerProfileView: View {
    
    var parentWidth: CGFloat
//    @Binding var brawler_st: BrawlerStandard
    var brawler_st: BrawlerStandard
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
//                if viewModel.reload_speed_gear_brawlers.contains(brawler?.name ?? " ") {
                if brawlerStandard.epicGear == .reloadSpeed {
                    SingleGearView(imageName: "RELOAD SPEED", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "RELOAD SPEED"), offset: true)
                }
                
//                if viewModel.super_charge_gear_brawlers.contains(brawler?.name ?? " ") {
                if brawlerStandard.epicGear == .superCharge {
                    SingleGearView(imageName: "SUPER CHARGE", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "SUPER CHARGE"), offset: true)
                }
                
//                if viewModel.pet_power_gear_brawlers.contains(brawler?.name ?? " ") {
                if brawlerStandard.epicGear == .petPower {
                    SingleGearView(imageName: "PET POWER", withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "PET POWER"), offset: true)
                }
                
                
//                let gearBrawlersSet = Set(viewModel.reload_speed_gear_brawlers)
//                    .union(viewModel.super_charge_gear_brawlers)
//                    .union(viewModel.pet_power_gear_brawlers)
                
                
                //신화기어 표시
                switch brawler?.name ?? "" {
                case "TICK":
                    SingleGearView(
                        imageName: "THICC HEAD",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "THICC HEAD"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "GENE":
                    SingleGearView(
                        imageName: "TALK TO THE HAND",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "TALK TO THE HAND"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "CROW":
                    SingleGearView(
                        imageName: "ENDURING TOXIN",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "ENDURING TOXIN"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "SANDY":
                    SingleGearView(
                        imageName: "EXHAUSTING STORM",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "EXHAUSTING STORM"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "SPIKE":
                    SingleGearView(
                        imageName: "STICKY SPIKES",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "STICKY SPIKES"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "LEON":
                    SingleGearView(
                        imageName: "LINGERING SMOKE",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "LINGERING SMOKE"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "AMBER":
                    SingleGearView(
                        imageName: "STICKY OIL",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "STICKY OIL"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "EVE":
                    SingleGearView(
                        imageName: "QUADRUPLETS",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "QUADRUPLETS"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "PAM":
                    SingleGearView(
                        imageName: "SUPER TURRET",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "SUPER TURRET"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
                    )
                    
                case "MORTIS":
                    SingleGearView(
                        imageName: "BAT STORM",
                        withItem: viewModel.judgeGear(gears: brawler?.gears ?? [], gear: "BAT STORM"),
//                        offset: !gearBrawlersSet.contains(brawler?.name ?? " ")
                        offset: brawlerStandard.epicGear == .none
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
//    @Binding var BrawlerStandard: BrawlerStandard
    var brawlerStandard: BrawlerStandard
    @Binding var brawler: Brawler?
    
    
    //viewModel
    @StateObject var viewModel: BrawlersViewModel = BrawlersViewModel()
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(brawlerStandard.first_gadget)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.first_gadget) ? 1 : 0)
                .colorMultiply(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.first_gadget) ? Color.white : Color(hexString: "585858"))
            
            Image(brawlerStandard.second_gadget)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.second_gadget) ? 1 : 0)
                .colorMultiply(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.second_gadget) ? Color.white : Color(hexString: "585858"))
            
            
            Image(brawlerStandard.first_starPower)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.first_starPower) ? 1 : 0)
                .colorMultiply(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.first_starPower) ? Color.white : Color(hexString: "585858"))
            
            Image(brawlerStandard.second_starPower)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .saturation(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.second_starPower) ? 1 : 0)
                .colorMultiply(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.second_starPower) ? Color.white : Color(hexString: "585858"))
            
            
            Image(brawlerStandard.hypercharge)
                .resizable()
                .frame(width: imageSize - 10, height: imageSize)
                .saturation(viewModel.judgeHypercharge(brawlerStandard.hypercharge) ? 1 : 0)
                .colorMultiply(viewModel.judgeHypercharge(brawlerStandard.hypercharge) ? Color.white : Color(hexString: "585858"))
            
            
            
        }
        .frame(width: parentWidth - 25, height: 80)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)
        
    }
}





struct MoneyCountView: View {
    
    var parentWidth: CGFloat
    @Binding var brawler: Brawler?
//    @Binding var brawlerStandard: BrawlerStandard
    var brawlerStandard: BrawlerStandard
    
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
                ppCount = brawlersViewModel.calculatePP(brawler: brawler, brawlerStandard: brawlerStandard)
                creditCount = brawlersViewModel.calculateCredit(brawler: brawler, brawlerStandard: brawlerStandard)
                coinCount = brawlersViewModel.calculateCoin(brawler: brawler, brawlerStandard: brawlerStandard)
//
                appState.totalPP += brawlersViewModel.calculatePP(brawler: brawler, brawlerStandard: brawlerStandard)
                appState.totalCredit += brawlersViewModel.calculateCredit(brawler: brawler, brawlerStandard: brawlerStandard)
                appState.totalCoin += brawlersViewModel.calculateCoin(brawler: brawler, brawlerStandard: brawlerStandard)
                
            }
        }
        .onAppear {
        }
    }
}










//#Preview {
//    BrawlerProfileView()
//}
