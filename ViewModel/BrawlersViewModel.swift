//
//  BrawlerViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/6/24.
//

import Foundation
import SwiftUI
import Combine

//MARK: - DataSource
protocol HyperchargeDataSource {
    func judgeHypercharge(_ hypercharge: String) -> Bool
    func addHyperchargeArray(_ hypercharge: String)
    func removeHyperchargeArray(_ hypercharge: String)
}

class HyperchargeDataSourceImpl: HyperchargeDataSource {
    let key = "hyperchargeArray"
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        let array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if array.contains(hypercharge) {
            return true
        } else {
            return false
        }
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if !array.contains(hypercharge) {
            array.append(hypercharge)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if let index = array.firstIndex(of: hypercharge) {
            array.remove(at: index)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
}

//MARK: - Repository
protocol BrawlersRepository {
    func getBrawlers() -> [BrawlerStandard]
    func judgeHypercharge(_ hypercharge: String) -> Bool
    func addHyperchargeArray(_ hypercharge: String)
    func removeHyperchargeArray(_ hypercharge: String)
}

class BrawlersRepositoryImpl: BrawlersRepository {
    private let service: BrawlersService
    private let dataSource: HyperchargeDataSource
    
    init(service: BrawlersService, dataSource: HyperchargeDataSource) {
        self.service = service
        self.dataSource = dataSource
        
    }
   
    func getBrawlers() -> [BrawlerStandard] {
       return service.allBrawlers
    }
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        return dataSource.judgeHypercharge(hypercharge)
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        dataSource.addHyperchargeArray(hypercharge)
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        dataSource.removeHyperchargeArray(hypercharge)
    }
}

//MARK: - UseCase
protocol BrawlersUseCase {
    func judgeGear(gears: [Gear], gear: String) -> Bool
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool
    
    func calculatePP(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int
    func calculateCredit(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int
    func calculateCoin(brawler: Brawler?, brawlerStandard: BrawlerStandard) -> Int
    
}

class BrawlersUseCaseImpl: BrawlersUseCase {
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
            let key = "hyperchargeArray"
            let array = UserDefaults.standard.stringArray(forKey: key) ?? []
            
            if brawlerStandard.hypercharge != "" {
                if !array.contains(brawlerStandard.hypercharge) {
                    coin += 5000
                }
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
    
    func judgeGear(gears: [Gear], gear: String) -> Bool {
        for g in gears {
            if g.name == gear {
                return true
            }
        }
        return false
    }
    
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool {
        for g in gadgets {
            if g.name == gadget {
                return true
            }
        }
        return false
    }
    
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool {
        for s in starPowers {
            if s.name == starPower {
                return true
            }
        }
        return false
    }
}




// 데이터 로딩을 관리하는 ViewModel
class BrawlersViewModel: ObservableObject {

    @Published var all_brawlers_standard: [BrawlerStandard] = []
    private let repository: BrawlersRepository
    private let useCase: BrawlersUseCase
    
    init(repository: BrawlersRepository, useCase: BrawlersUseCase) {
        self.repository = repository
        self.useCase = useCase
        all_brawlers_standard = repository.getBrawlers()
    }
    
    func judgeGear(gears: [Gear], gear: String) -> Bool {
        return useCase.judgeGear(gears: gears, gear: gear)
    }
    
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool {
        return useCase.judgeGadget(gadgets: gadgets, gadget: gadget)
    }
    
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool {
        return useCase.judgeStarPower(starPowers: starPowers, starPower: starPower)
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
}


