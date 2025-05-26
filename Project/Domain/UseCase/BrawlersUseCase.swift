//
//  BrawlersUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation

//MARK: - Judge
protocol BrawlerJudge {
    func judgeGear(gears: [Gear], gear: String) -> Bool
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool
    
}

class BrawlerJudgeImpl: BrawlerJudge {
    func judgeGear(gears: [Gear], gear: String) -> Bool {
        return gears.contains { $0.name == gear }
    }
    
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool {
        return gadgets.contains { $0.name == gadget }
    }
    
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool {
        return starPowers.contains { $0.name == starPower }
    }
}



//MARK: - UseCase
protocol BrawlersUseCase {
    func calculatePP(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int
    func calculateCredit(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int
    func calculateCoin(brawler: Brawler?, brawlerStandard: BrawlerStandard) -> Int
}

class BrawlersUseCaseImpl: BrawlersUseCase {
    private let repository: BrawlersRepository
    
    init(repository: BrawlersRepository) {
        self.repository = repository
    }
    
    
    
    func calculatePP(brawler: Brawler?, brawlerStandard: BrawlerStandard) -> Int {
        if brawler?.name == "" || brawler?.power == 1 {
            return 1440+890+550+340+210+130+80+50+30+20
        } else if brawler?.power == 2 {
            return 1440+890+550+340+210+130+80+50+30
        } else if brawler?.power == 3 {
            return 1440+890+550+340+210+130+80+50
        } else if brawler?.power == 4 {
            return 1440+890+550+340+210+130+80
        } else if brawler?.power == 5 {
            return 1440+890+550+340+210+130
        } else if brawler?.power == 6 {
            return 1440+890+550+340+210
        } else if brawler?.power == 7 {
            return 1440+890+550+340
        } else if brawler?.power == 8 {
            return 1440+890+550
        } else if brawler?.power == 9 {
            return 1440+890
        } else if brawler?.power == 10 {
            return 1440
        } else if brawler?.power == 11 {
           return 0
       }
        return 0
    }
    
    func calculateCredit(brawler: Brawler?, brawlerStandard: BrawlerStandard) -> Int {
        if brawler?.name == "" {
            switch brawlerStandard.rarity {
            case .basic:
                return 0
            case .rare:
                return 160
            case .superRare:
                return 430
            case .epic:
                return 925
            case .mythic:
                return 1900
            case .legendary:
                return 3800
            case .ultraLegendary:
                return 5500
            }
        }
        return 0
    }
    
    func calculateCoin(brawler: Brawler?, brawlerStandard: BrawlerStandard) -> Int {
   
        var coin = 0
        
        if brawler != nil {
            //하이퍼차지 계산
            
            if !repository.judgeHypercharge(brawlerStandard.hypercharge) && brawlerStandard.hypercharge != "" {
                coin += 5000
            }
            
            //레벨 계산
            let powerCoins = [2800, 1875, 1250, 800, 480, 290, 140, 75, 35, 20]
            if let power = brawler?.power, power >= 1 {
                coin += powerCoins.prefix(11 - power).reduce(0, +)
            } else if brawler?.name == "" {
                coin += powerCoins.prefix(11).reduce(0, +)
            }
            
            //가젯, 스파 계산
            if brawler != nil {
                if !brawler!.gadgets.contains(where: { $0.name == brawlerStandard.first_gadget}) {
                    coin += 1000
                }
                if !brawler!.gadgets.contains(where: { $0.name == brawlerStandard.second_gadget}) {
                    coin += 1000
                }
                if !brawler!.starPowers.contains(where: { $0.name == brawlerStandard.first_starPower}) {
                    coin += 2000
                }
                if !brawler!.starPowers.contains(where: { $0.name == brawlerStandard.second_starPower}) {
                    coin += 2000
                }
            }
            
            
            //기어 계산
            //신화 기어 계산
            if brawlerStandard.mythicGear != .none { //신화 기어를 가지고 있는 브롤러
                if !brawler!.gears.contains(where: { $0.name == brawlerStandard.mythicGear.rawValue }) {
                    coin += 2000
                }
            }
            
            //영웅 기어 계산
            if brawlerStandard.epicGear != .none {
                if !brawler!.gears.contains(where: { $0.name == brawlerStandard.epicGear.rawValue }) {
                    coin += 1500
                }
            }
            
            //초희귀 기어 계산
            for gear in RareGear.allCases {
                if !brawler!.gears.contains(where: { $0.name == gear.rawValue }) {
                    coin += 1000
                }
            }
        }
        return coin
    }
    
}
