//
//  BattleLogUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift




protocol BattleLogUseCase {
    func checkMode(mode: String) -> String
    func fetchBattleLog() -> Observable<[BattleLogModel]>
    func getMapName(mapName: String) -> String
}

class BattleLogUseCaseImpl: BattleLogUseCase {
    let repository: BattleLogRepository
    
    init(repository: BattleLogRepository) {
        self.repository = repository
    }
    
    
    
    func checkMode(mode: String) -> String {
        switch mode {
        case "gemGrab": return "gem_grab_icon"
        case "bounty": return "bounty_icon"
        case "brawlBall": return "brawl_ball_icon"
        case "heist": return "heist_icon"
        case "hotZone": return "hot_zone_icon"
        case "knockout": return "knock_out_icon"
        case "soloShowdown": return "showdown_icon"
        case "duoShowdown": return "duo_showdown_icon"
        case "trioShowdown": return "trio_showdown_icon"
        case "duels": return "duels_icon"
        case "wipeout": return "wipeout_icon"
            
        default: return ""
        }
    }
    
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return repository.fetchBattleLog()
            .map { battleLogs in
               // 날짜 내림차순으로 정렬 (최신 날짜가 맨 앞에)
               return battleLogs.sorted { first, second in
                   let firstDate = self.parseDate(from: first.date)
                   let secondDate = self.parseDate(from: second.date)
                   return firstDate > secondDate // 내림차순 정렬
               }
           }
    }
    
    // 날짜 문자열을 Date 객체로 변환하는 private 메서드
    private func parseDate(from dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: dateString) ?? Date.distantPast
    }
    
    
    // 기기 언어가 한국어이면 영어 맵 이름을 한국어로 변환
    func getMapName(mapName: String) -> String {
        let languageJudge = Locale.current.language.languageCode?.identifier == "ko"
        
        switch mapName {
        // 젬그랩
        case "Hard Rock Mine":
            return languageJudge ? "암석 광산" : mapName
        case "Crystal Arcade":
            return languageJudge ? "수정 오락실" : mapName
        case "Deathcap Trap":
            return languageJudge ? "독버섯 함정" : mapName
        case "Gem Fort":
            return languageJudge ? "보석 요새" : mapName
        case "Undermine":
            return languageJudge ? "흔들 광산" : mapName
        case "Double Swoosh":
            return languageJudge ? "이중 곡선" : mapName
        case "Flooded Mine":
            return languageJudge ? "침수된 광산" : mapName
        case "Mincraft Madness":
            return languageJudge ? "광가의 광산 열차" : mapName
        case "Acute Angle":
            return languageJudge ? "예리한 각도" : mapName
        case "Rustic Arcade":
            return languageJudge ? "오래된 오락실" : mapName
        case "Open Space":
            return languageJudge ? "열린 공간" : mapName
        case "Deep Diner":
            return languageJudge ? "지하굴 식당" : mapName
        case "CHill Space":
            return languageJudge ? "조용했던 동네" : mapName
        case "Echo Chamber":
            return languageJudge ? "메아리 동굴" : mapName
        case "Gift Wrap":
            return languageJudge ? "선물 포장" : mapName
        case "Diamond Dust":
            return languageJudge ? "다이아몬드 더스트" : mapName
        case "Four Squared":
            return languageJudge ? "포 스퀘어" : mapName
        case "Bouncing Diner":
            return languageJudge ? "점프 맛집" : mapName
        case "Escape Velocity":
            return languageJudge ? "급속 탈출" : mapName
        case "Cell Division":
            return languageJudge ? "분열" : mapName
        case "Spring Trap":
            return languageJudge ? "점핑 트랩" : mapName
        case "Cross Cut":
            return languageJudge ? "지름길" : mapName
        case "Stock Crash":
            return languageJudge ? "주식 붕괴" : mapName
        case "Snake Shop":
            return languageJudge ? "뱀의 가게" : mapName
        case "Royal Flush":
            return languageJudge ? "로얄 플러시" : mapName
        case "Lilygear Lake":
            return languageJudge ? "릴리기어 호수" : mapName
            
            // 쇼다운
        case "Flying Fantasie":
            return languageJudge ? "플라잉 판타지" : mapName
        case "Skull Creak":
            return languageJudge ? "해골천" : mapName
        case "Cavern Churn":
            return languageJudge ? "우당탕 진흙탕" : mapName
        case "Feast or Famine":
            return languageJudge ? "모 아니면 도" : mapName
        case "Double Trouble":
            return languageJudge ? "더블 트러블" : mapName
        case "Island Invasion":
            return languageJudge ? "무인도 침략" : mapName
        case "Stormy Plains":
            return languageJudge ? "폭풍의 대지" : mapName
        case "Safety Center":
            return languageJudge ? "안전 센터" : mapName
        case "Rockwall Brawl":
            return languageJudge ? "바위 장벽 전투" : mapName
        case "Mystical Thirty Three":
            return languageJudge ? "미스터리 33" : mapName
            
        // 브롤볼
        case "Pinball Breams":
            return languageJudge ? "핀볼 드림" : mapName
        case "Center Stage":
            return languageJudge ? "센터 스테이지" : mapName
        case "Beach Ball":
            return languageJudge ? "비치볼" : mapName
        case "Galaxy Arene":
            return languageJudge ? "은하수 경기장" : mapName
        case "Encirclement":
            return languageJudge ? "빙글빙글" : mapName
        case "Retina":
            return languageJudge ? "레티나" : mapName
        case "Sneaky Fields":
            return languageJudge ? "스니키 필드" : mapName
        case "Sunny Soccer":
            return languageJudge ? "화창한 날" : mapName
            
            
            
        // 녹아웃
        case "Healthy Middle Ground":
            return languageJudge ? "적당한 중간지점" : mapName
        case "Goldarm Gluch":
            return languageJudge ? "골드암 협곡" : mapName
        case "Belle`s Rock":
            return languageJudge ? "벨스 락" : mapName
        case "Deep End":
            return languageJudge ? "딥 엔드" : mapName
        case "Flaring Phoenix":
            return languageJudge ? "타오르는 불사조" : mapName
        case "Out in the Open":
            return languageJudge ? "오픈 월드" : mapName
        case "New Horizons":
            return languageJudge ? "새로운 지평선" : mapName
        
            
        // 하이스트
            
        // 핫 존
        case "In the Liminal":
            return languageJudge ? "경계 속으로" : mapName
        
        // 듀얼
        case "No Surrender":
            return languageJudge ? "항복 없는 결투의 장" : mapName
        
        // 기타
        case "Snowcone Square":
            return languageJudge ? "스노우콘 광장" : mapName
            
        default:
            return mapName
        }
    }
}
