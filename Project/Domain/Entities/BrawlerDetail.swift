//
//  BrawlerDetail.swift
//  Brawlytics
//
//  Created by Claude on 12/27/24.
//

import Foundation

/*
 사용 예제:

 1. API 호출 및 응답 받기:
 ```swift
 let dataSource = BrawlerRemoteDataSourceImpl()
 dataSource.getUserBrawlers(searchText: "#22YJV82RP") { brawlers in
     // brawlers: [BrawlerDetail]

     // 전체 필요 코인 계산
     let totalCoins = brawlers.calculateTotalRequiredCoins()
     print("총 필요 코인: \(totalCoins)")

     // 브롤러별 필요 코인 계산
     let perBrawler = brawlers.calculateCoinsPerBrawler()
     for (brawler, coins) in perBrawler {
         if coins > 0 {
             print("\(brawler.name): \(coins) 코인 필요")
         }
     }

     // UseCase 사용
     let result = useCase.calculateRequiredCoinsFromDetails(brawlers)
     print("총: \(result.totalCoins), 개별: \(result.perBrawler)")
 }
 ```

 2. Kingfisher로 이미지 로딩:
 ```swift
 import Kingfisher

 // 브롤러 이미지
 if let url = brawler.imageURL(baseURL: Constants.baseURL) {
     imageView.kf.setImage(with: url)
 }

 // 아이템 이미지 (가젯, 스타파워 등)
 if let url = brawler.itemImageURL(baseURL: Constants.baseURL, imageName: brawler.firstGadget.image) {
     gadgetImageView.kf.setImage(with: url)
 }
 ```

 3. 코인 계산 상세:
 - 소유한 브롤러:
   * 파워 레벨: 현재 레벨 → 11레벨까지 필요한 코인
   * 아이템: 소유하지 않은 아이템만 계산

 - 소유하지 않은 브롤러:
   * 파워 레벨: 1레벨 → 11레벨 (7765 코인)
   * 아이템: 모든 아이템 구매 비용 (가젯 2000 + 스타파워 4000 + 하이퍼차지 5000 + 기어)

 - 아이템별 비용:
   * 가젯: 각 1000 코인
   * 스타파워: 각 2000 코인
   * 하이퍼차지: 5000 코인
   * 레어 기어: 각 1000 코인
 */

// MARK: - 서버 API 응답 모델 (/brawlers?playertag=XXX)

/// 브롤러 상세 정보 (아이템 소유 여부 포함)
struct BrawlerDetail: Codable, Equatable {
    let id: Int
    let name: String
    let owned: Bool
    let rarity: String
    let role: String

    // 브롤러를 소유한 경우에만 제공되는 정보
    let power: Int?
    let rank: Int?
    let trophies: Int?
    let highestTrophies: Int?

    // 아이템 정보 (name, image, owned)
    let firstGadget: BrawlerItem
    let secondGadget: BrawlerItem
    let firstStarPower: BrawlerItem
    let secondStarPower: BrawlerItem
    let hypercharge: BrawlerItem
    let gadgetBuff: BrawlerItem
    let starPowerBuff: BrawlerItem
    let hyperchargeBuff: BrawlerItem

    // 기어 정보
    let gears: [GearItem]

    init() {
        id = 0
        name = ""
        owned = false
        rarity = "rare"
        role = "damageDealer"
        power = nil
        rank = nil
        trophies = nil
        highestTrophies = nil
        firstGadget = BrawlerItem()
        secondGadget = BrawlerItem()
        firstStarPower = BrawlerItem()
        secondStarPower = BrawlerItem()
        hypercharge = BrawlerItem()
        gadgetBuff = BrawlerItem()
        starPowerBuff = BrawlerItem()
        hyperchargeBuff = BrawlerItem()
        gears = []
    }

    init(
        id: Int,
        name: String,
        owned: Bool,
        rarity: String,
        role: String,
        power: Int?,
        rank: Int?,
        trophies: Int?,
        highestTrophies: Int?,
        firstGadget: BrawlerItem,
        secondGadget: BrawlerItem,
        firstStarPower: BrawlerItem,
        secondStarPower: BrawlerItem,
        hypercharge: BrawlerItem,
        gadgetBuff: BrawlerItem,
        starPowerBuff: BrawlerItem,
        hyperchargeBuff: BrawlerItem,
        gears: [GearItem]
    ) {
        self.id = id
        self.name = name
        self.owned = owned
        self.rarity = rarity
        self.role = role
        self.power = power
        self.rank = rank
        self.trophies = trophies
        self.highestTrophies = highestTrophies
        self.firstGadget = firstGadget
        self.secondGadget = secondGadget
        self.firstStarPower = firstStarPower
        self.secondStarPower = secondStarPower
        self.hypercharge = hypercharge
        self.gadgetBuff = gadgetBuff
        self.starPowerBuff = starPowerBuff
        self.hyperchargeBuff = hyperchargeBuff
        self.gears = gears
    }

    static func == (lhs: BrawlerDetail, rhs: BrawlerDetail) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - 아이템 모델

/// 가젯, 스타파워, 하이퍼차지 등의 아이템
struct BrawlerItem: Codable, Equatable {
    let name: String
    let image: String?
    let owned: Bool

    init(name: String = "", image: String? = nil, owned: Bool = false) {
        self.name = name
        self.image = image
        self.owned = owned
    }
}

// MARK: - 기어 모델

/// 기어 아이템
struct GearItem: Codable, Equatable {
    let name: String
    let owned: Bool

    init(name: String = "", owned: Bool = false) {
        self.name = name
        self.owned = owned
    }
}

// MARK: - 역할 Enum

enum BrawlerRole: String, Codable, CaseIterable {
    case tanker = "tanker"
    case assassin = "assassin"
    case supporter = "supporter"
    case controller = "controller"
    case damageDealer = "damageDealer"
    case marksmen = "marksmen"
    case thrower = "thrower"

    var displayName: String {
        switch self {
        case .tanker: return "탱커"
        case .assassin: return "암살자"
        case .supporter: return "서포터"
        case .controller: return "컨트롤러"
        case .damageDealer: return "딜러"
        case .marksmen: return "저격수"
        case .thrower: return "투척수"
        }
    }
}

// MARK: - 희귀도 Enum

enum BrawlerRarity: String, Codable, CaseIterable {
    case basic = "basic"
    case rare = "rare"
    case superRare = "superRare"
    case epic = "epic"
    case mythic = "mythic"
    case legendary = "legendary"
    case ultraLegendary = "ultraLegendary"

    var displayName: String {
        switch self {
        case .basic: return "기본"
        case .rare: return "레어"
        case .superRare: return "슈퍼 레어"
        case .epic: return "에픽"
        case .mythic: return "미스틱"
        case .legendary: return "레전더리"
        case .ultraLegendary: return "울트라 레전더리"
        }
    }
}

// MARK: - 편의 확장

extension BrawlerDetail {
    /// 브롤러 이미지 URL 생성
    func imageURL(baseURL: String) -> URL? {
        guard let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return nil
        }
        let urlString = "\(baseURL)/uploads/brawlers/\(encodedName)/\(encodedName).png"
        return URL(string: urlString)
    }

    /// 아이템 이미지 URL 생성
    func itemImageURL(baseURL: String, imageName: String?) -> URL? {
        guard let imageName = imageName,
              !imageName.isEmpty,
              let encodedBrawlerName = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let encodedImageName = imageName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return nil
        }
        let urlString = "\(baseURL)/uploads/brawlers/\(encodedBrawlerName)/\(encodedImageName)"
        return URL(string: urlString)
    }

    /// 브롤러 이미지 URL (기본 서버 URL 사용)
    var brawlerImageURL: URL? {
        return imageURL(baseURL: Constants.serverURL)
    }

    /// 아이템 이미지 URL (기본 서버 URL 사용)
    func itemURL(for imageName: String?) -> URL? {
        return itemImageURL(baseURL: Constants.serverURL, imageName: imageName)
    }

    /// 필요한 코인 계산 (소유하지 않은 브롤러도 포함)
    func calculateRequiredCoins() -> Int {
        var totalCoins = 0

        // 1. 파워 레벨 업그레이드 코인
        let powerCoins = [2800, 1875, 1250, 800, 480, 290, 140, 75, 35, 20]

        if owned {
            // 소유한 브롤러: 현재 레벨 → 11레벨
            if let currentPower = power, currentPower >= 1, currentPower < 11 {
                totalCoins += powerCoins.suffix(from: currentPower - 1).prefix(11 - currentPower).reduce(0, +)
            }
        } else {
            // 소유하지 않은 브롤러: 1레벨 → 11레벨 (모든 레벨업 비용)
            totalCoins += powerCoins.reduce(0, +)  // 7765 코인
        }

        // 2. 가젯 (각 1000 코인)
        if !firstGadget.name.isEmpty && !firstGadget.owned {
            totalCoins += 1000
        }
        if !secondGadget.name.isEmpty && !secondGadget.owned {
            totalCoins += 1000
        }

        // 3. 스타파워 (각 2000 코인)
        if !firstStarPower.name.isEmpty && !firstStarPower.owned {
            totalCoins += 2000
        }
        if !secondStarPower.name.isEmpty && !secondStarPower.owned {
            totalCoins += 2000
        }

        // 4. 하이퍼차지 (5000 코인)
        if !hypercharge.name.isEmpty && !hypercharge.owned {
            totalCoins += 5000
        }

        // 5. 기어 (각 1000 코인) - 현재는 레어 기어만 계산
        for gear in gears {
            if !gear.owned {
                totalCoins += 1000
            }
        }

        // 6. 버피 (각 1000 코인)
        if !gadgetBuff.name.isEmpty && !gadgetBuff.owned {
            totalCoins += 1000
        }
        if !starPowerBuff.name.isEmpty && !starPowerBuff.owned {
            totalCoins += 1000
        }
        if !hyperchargeBuff.name.isEmpty && !hyperchargeBuff.owned {
            totalCoins += 1000
        }

        return totalCoins
    }

    /// 필요한 PP 계산
    func calculateRequiredPP() -> Int {
        var totalPP = 0

        if !owned {
            // 소유하지 않은 브롤러: 1레벨 기준 전체 PP
            totalPP = 1440+890+550+340+210+130+80+50+30+20  // 3740 PP
        } else {
            let currentPower = power ?? 1

            if currentPower == 1 {
                totalPP = 1440+890+550+340+210+130+80+50+30+20
            } else if currentPower == 2 {
                totalPP = 1440+890+550+340+210+130+80+50+30
            } else if currentPower == 3 {
                totalPP = 1440+890+550+340+210+130+80+50
            } else if currentPower == 4 {
                totalPP = 1440+890+550+340+210+130+80
            } else if currentPower == 5 {
                totalPP = 1440+890+550+340+210+130
            } else if currentPower == 6 {
                totalPP = 1440+890+550+340+210
            } else if currentPower == 7 {
                totalPP = 1440+890+550+340
            } else if currentPower == 8 {
                totalPP = 1440+890+550
            } else if currentPower == 9 {
                totalPP = 1440+890
            } else if currentPower == 10 {
                totalPP = 1440
            } else if currentPower == 11 {
               totalPP = 0
            }
        }

        // 버피 (각 2000 PP)
        if !gadgetBuff.name.isEmpty && !gadgetBuff.owned {
            totalPP += 2000
        }
        if !starPowerBuff.name.isEmpty && !starPowerBuff.owned {
            totalPP += 2000
        }
        if !hyperchargeBuff.name.isEmpty && !hyperchargeBuff.owned {
            totalPP += 2000
        }

        return totalPP
    }

    /// 필요한 크레딧 계산
    func calculateRequiredCredit() -> Int {
        if !owned {
            // rarity 문자열을 BrawlerRarity로 변환
            guard let rarityEnum = BrawlerRarity(rawValue: rarity) else {
                return 0
            }

            switch rarityEnum {
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
}

// MARK: - 배열 확장

extension Array where Element == BrawlerDetail {
    /// 전체 필요 코인 계산
    func calculateTotalRequiredCoins() -> Int {
        return self.reduce(0) { $0 + $1.calculateRequiredCoins() }
    }

    /// 브롤러별 필요 코인 계산
    func calculateCoinsPerBrawler() -> [(brawler: BrawlerDetail, coins: Int)] {
        return self.map { ($0, $0.calculateRequiredCoins()) }
    }

    /// 소유한 브롤러만 필터링
    var ownedBrawlers: [BrawlerDetail] {
        return self.filter { $0.owned }
    }

    /// 소유하지 않은 브롤러만 필터링
    var notOwnedBrawlers: [BrawlerDetail] {
        return self.filter { !$0.owned }
    }
}
