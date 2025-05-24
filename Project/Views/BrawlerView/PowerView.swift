//
//  PowerView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import SwiftUI


struct PowerView: View {
    
    @State var imageSize: CGFloat = 50
    
    //Binding
    var parentWidth: CGFloat
    var brawlerStandard: BrawlerStandard
    @Binding var brawler: Brawler?
    
    
    //viewModel
    let viewModel:BrawlersViewModel
        
    init(
        parentWidth: CGFloat,
        brawlerStandard: BrawlerStandard,
        brawler: Binding<Brawler?>,
        viewModel: BrawlersViewModel
    ) {
        self.parentWidth = parentWidth
        self.brawlerStandard = brawlerStandard
        self._brawler = brawler
        self.viewModel = viewModel
        }
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            if !brawlerStandard.first_gadget.isEmpty {
                Image(brawlerStandard.first_gadget)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .saturation(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.first_gadget) ? 1 : 0)
                    .colorMultiply(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.first_gadget) ? Color.white : Color(hexString: "585858"))
            }
            
            if !brawlerStandard.second_gadget.isEmpty {
                Image(brawlerStandard.second_gadget)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .saturation(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.second_gadget) ? 1 : 0)
                    .colorMultiply(viewModel.judgeGadget(gadgets: brawler?.gadgets ?? [], gadget: brawlerStandard.second_gadget) ? Color.white : Color(hexString: "585858"))
            }
            
            if !brawlerStandard.first_starPower.isEmpty {
                Image(brawlerStandard.first_starPower)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .saturation(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.first_starPower) ? 1 : 0)
                    .colorMultiply(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.first_starPower) ? Color.white : Color(hexString: "585858"))
            }
            
            if !brawlerStandard.second_starPower.isEmpty {
                Image(brawlerStandard.second_starPower)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .saturation(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.second_starPower) ? 1 : 0)
                    .colorMultiply(viewModel.judgeStarPower(starPowers: brawler?.starPowers ?? [], starPower: brawlerStandard.second_starPower) ? Color.white : Color(hexString: "585858"))
            }
            
            if !brawlerStandard.hypercharge.isEmpty {
                Image(brawlerStandard.hypercharge)
                    .resizable()
                    .frame(width: imageSize - 10, height: imageSize)
                    .saturation(viewModel.judgeHypercharge(brawlerStandard.hypercharge) ? 1 : 0)
                    .colorMultiply(viewModel.judgeHypercharge(brawlerStandard.hypercharge) ? Color.white : Color(hexString: "585858"))
            }
            
        }
        .frame(width: parentWidth - 25, height: 70)
        .background(Color(hexString: "4C658D", opacity: 0.53))
        .cornerRadius(15)
        
    }
}
