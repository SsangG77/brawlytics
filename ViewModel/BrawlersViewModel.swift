//
//  BrawlerViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/6/24.
//

import Foundation
import SwiftUI
import Combine


protocol BrawlersRepository {
    
}



protocol BrawlersUseCase {
    func judgeGear(gears: [Gear], gadget: String) -> Bool
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool
    
    func judgeHypercharge(_ hypercharge: String) -> Bool
    func addHyperchargeArray(_ hypercharge: String)
    func removeHyperchargeArray(_ hypercharge: String)
    
    func calculatePP(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int
    func calculateCredit(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int
    func calculateCoin(brawler: Brawler?, brawlerStandard: BrawlerStandard) -> Int
    
}


// 데이터 로딩을 관리하는 ViewModel
class BrawlersViewModel: ObservableObject {

    
    //MARK: - 기어 브롤러 배열
//    //영웅기어를 가지고있는 브롤러 배열
//    @Published var reload_speed_gear_brawlers = ["BELLE", "EVE","LOLA","BO","BROCK","COLT","8-BIT","AMBER","RICO","GRIFF"]
//    @Published var super_charge_gear_brawlers = ["ASH","LOU","OTIS","BULL","NANI","BONNIE","EDGAR","SPROUT","EL PRIMO","JACKY"]
//    @Published var pet_power_gear_brawlers = ["NITA","JESSIE","PENNY","TARA","MR. P"]
    
    
//    신화기어를 가지고 있는 브롤러 배열
//    @Published var mythic_gear_brawlers = ["TICK","GENE","CROW","SANDY","SPIKE","LEON","AMBER","EVE","PAM","MORTIS"]
    
    
    //MARK: - 기어 배열
    //초희귀 기어 이름 배열
    @Published var gear_names = ["SPEED", "HEALTH", "DAMAGE", "VISION", "SHIELD", "GADGET COOLDOWN"]
    
    
    //신화 기어 이름 배열
    @Published var mythic_gear_name = [
        "THICC HEAD", //틱
        "TALK TO THE HAND", //진
        "ENDURING TOXIN", //크로우
        "EXHAUSTING STORM", //샌디
        "STICKY SPIKES", //스파이크
        "LINGERING SMOKE", //레온
        "STICKY OIL", //앰버
        "QUADRUPLETS", //이브
        "SUPER TURRET", //팸
        "BAT STORM" //모티스
    ]
    
    @Published var all_brawlers_standard: [BrawlerStandard] = []

    let service = BrawlersService()
    
    init() {
        all_brawlers_standard = service.allBrawlers
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
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        let key = "hyperchargeArray"
        let array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if array.contains(hypercharge) {
            return true
        } else {
            return false
        }
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        let key = "hyperchargeArray"
        
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if !array.contains(hypercharge) {
            array.append(hypercharge)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        let key = "hyperchargeArray"
        
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if let index = array.firstIndex(of: hypercharge) {
            array.remove(at: index)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
    
    
    func calculatePP(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int {
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
    
    func calculateCredit(brawler:Brawler?, brawlerStandard: BrawlerStandard) -> Int {
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
            if mythic_gear_brawlers.contains(brawler!.name) { //신화 기어를 가지고 있는 브롤러
                if !mythic_gear_name.contains(where: { gearName in
                    brawler!.gears.contains { $0.name == gearName }
                }) {
                    coin += 2000
                }
            }
            
            //영웅 기어 계산
            if /*reload_speed_gear_brawlers.contains(brawler!.name)*/ brawlerStandard.epicGear == .reloadSpeed {
                if !brawler!.gears.contains(where: { $0.name == "RELOAD SPEED" }) {
                    coin += 1500
                }
            }
            if /*super_charge_gear_brawlers.contains(brawler!.name)*/ brawlerStandard.epicGear == .superCharge {
                if !brawler!.gears.contains(where: { $0.name == "SUPER CHARGE"}) {
                    coin += 1500
                }
            }
            if /*pet_power_gear_brawlers.contains(brawler!.name)*/ brawlerStandard.epicGear == .petPower {
                if !brawler!.gears.contains(where: { $0.name == "PET POWER"}) {
                    coin += 1500
                }
            }
            
            //초희귀 기어 계산
            for gear in gear_names {
                if !brawler!.gears.contains(where: { $0.name == gear}) {
                    coin += 1000
                }
            }
//            coin += 1000*(6 - brawler!.gears.count)
        }
        return coin
    }
    
    
    
    
    
    
    
}

