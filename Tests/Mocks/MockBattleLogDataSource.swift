//
//  MockBattleLogDataSource.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift


class MockBattleLogDataSourceImpl: BattleLogDataSource {
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return Observable.just([
            
            // trio showdown
            BattleLogModel(
                result: "showdown", mode: "trioShowdown", mapName: "3", date: "2024/03/21",
                teams: [
                    Team(
                        member: [
                            Member(name: "Ascsdcj", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "Bdfddssd", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "Casdsdas", brawler: "Colt", power: 6, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "Addsss", brawler: "Alli", power: 11, starPlayer: false),
                            Member(name: "Baa", brawler: "Brock", power: 1, starPlayer: false),
                            Member(name: "Cdddd", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "Adsasd", brawler: "Carl", power: 11, starPlayer: false),
                            Member(name: "Badsasdasdsd", brawler: "Ash", power: 1, starPlayer: false),
                            Member(name: "Casdasdasd", brawler: "Mortis", power: 6, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "Asdcsdcsdcdsc", brawler: "Darryl", power: 11, starPlayer: false),
                            Member(name: "Bdfdfdfd", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "Cerrrrrees", brawler: "edgar", power: 6, starPlayer: false),
                        ]
                    ),
                ]
            ),
            
            // duo showdown
            BattleLogModel(
                result: "showdown", mode: "duoShowdown", mapName: "2", date: "2024/03/22",
                teams: [
                    Team(
                        member: [
                            Member(name: "Adsasd", brawler: "Carl", power: 11, starPlayer: false),
                            Member(name: "Badsasdasdsd", brawler: "Ash", power: 1, starPlayer: false)
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "Bdfdfdfd", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "Cerrrrrees", brawler: "edgar", power: 6, starPlayer: false)
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                        ]
                    ),
                ]
            ),
            
            // solo showdown
            BattleLogModel(
                result: "showdown", mode: "soloShowdown", mapName: "1", date: "2024/03/22",
                teams: [
                    Team(
                        member: [
                            Member(name: "Adsasd", brawler: "Carl", power: 11, starPlayer: false),
                            Member(name: "Badsasdasdsd", brawler: "Ash", power: 1, starPlayer: false),
                            Member(name: "Bdfdfdfd", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "Cerrrrrees", brawler: "edgar", power: 6, starPlayer: false),
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "Adsasd", brawler: "Carl", power: 11, starPlayer: false),
                            Member(name: "Badsasdasdsd", brawler: "Ash", power: 1, starPlayer: false),
                            Member(name: "Bdfdfdfd", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "Cerrrrrees", brawler: "edgar", power: 6, starPlayer: false)
                        ]
                    ),
                ]
            ),
        ])
    }
}
