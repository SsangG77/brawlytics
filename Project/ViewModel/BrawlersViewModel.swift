//
//  BrawlerViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/6/24.
//

import Foundation
import SwiftUI
import Combine


class BrawlersViewModel: ObservableObject {

    @Published var all_brawlers_standard: [BrawlerStandard] = []
    private let repository: BrawlersRepository
    private let useCase: BrawlersUseCase
    private let judge: BrawlerJudge
    
    init(
        repository: BrawlersRepository,
        useCase: BrawlersUseCase,
        judge: BrawlerJudge
    ) {
        self.repository = repository
        self.useCase = useCase
        self.judge = judge
        all_brawlers_standard = repository.getBrawlers()
    }
    
    func judgeGear(gears: [Gear], gear: String) -> Bool {
        return judge.judgeGear(gears: gears, gear: gear)
    }
    
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool {
        return judge.judgeGadget(gadgets: gadgets, gadget: gadget)
    }
    
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool {
        return judge.judgeStarPower(starPowers: starPowers, starPower: starPower)
    }
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        return repository.judgeHypercharge(hypercharge)
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        repository.addHyperchargeArray(hypercharge)
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        repository.removeHyperchargeArray(hypercharge)
    }
    
    func calculatePP(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int {
        return useCase.calculatePP(brawler: brawler, brawlerStandard: brawlerStandard)
    }
    
    func calculateCredit(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int {
        return useCase.calculateCredit(brawler: brawler, brawlerStandard: brawlerStandard)
    }
    
    func calculateCoin(brawler: Brawler?, brawlerStandard: BrawlerStandard) -> Int {
        return useCase.calculateCoin(brawler: brawler, brawlerStandard: brawlerStandard)
    }
    
    var hyperchargedBrawlersGrouped: [[BrawlerStandard]] {
           let filtered = all_brawlers_standard.filter { !$0.hypercharge.isEmpty }
           return stride(from: 0, to: 3, by: 1).map { group in
               filtered.enumerated().compactMap { index, brawler in
                   index % 3 == group ? brawler : nil
               }
           }
       }
}




