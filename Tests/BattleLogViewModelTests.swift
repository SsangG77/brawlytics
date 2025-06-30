//
//  BattleLogViewModelTests.swift
//  BrawlyticsTests
//
//  Created by 차상진 on 6/30/25.
//

import Foundation
import XCTest
import RxSwift

@testable import Brawlytics


class MockBattleLogDataSourceImpl: BattleLogDataSource {
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return Observable.just([
            
            BattleLogModel(
                result: "win", mode: "brawlBall", mapName: "1", date: "2024/03/21",
                teams: [
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: true),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    )
                ]
            ),
            BattleLogModel(
                result: "lose", mode: "brawlBall", mapName: "2", date: "2024/03/22",
                teams: [
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: true),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    )
                ]
            ),
            BattleLogModel(
                result: "win", mode: "brawlBall", mapName: "3", date: "2024/03/24",
                teams: [
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: true),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    )
                ]
            )
        ])
    }
}




final class BattleLogViewModelTests: XCTestCase {
    
    var viewModel: BattleLogViewModel!
    var useCase: BattleLogUseCase!
    var repository: BattleLogRepository!
    var dataSource: MockBattleLogDataSourceImpl!
    
    override func setUp() {
        super.setUp()
        repository = BattleLogRepositoryImpl(dataSource: MockBattleLogDataSourceImpl())
        useCase = BattleLogUseCaseImpl(repository: repository)
        viewModel = BattleLogViewModel(useCase: useCase)
    }

    func testFetchBattleLog_assignsSortedLogs() {
        
        let expectation = XCTestExpectation(description: "Logs fetched and sorted")

        // When
        viewModel.fetchBattleLog()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Then
            XCTAssertEqual(self.viewModel.battleLog.count, 3)
            XCTAssertEqual(self.viewModel.battleLog.first?.date, "2024/03/24") // newest first
            XCTAssertEqual(self.viewModel.battleLog[1].date, "2024/03/22")
            XCTAssertEqual(self.viewModel.battleLog.last?.date, "2024/03/21")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testCheckMode_returnsCorrectIconName() {
        let iconName = viewModel.checkMode(mode: "brawlBall")
        XCTAssertEqual(iconName, "brawl_ball_icon")
    }
    
//    func testStarPlayer() {
//        let expectation = XCTestExpectation(description: "Logs fetched and sorted")
//        
//        viewModel.fetchBattleLog()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            XCTAssertEqual(self.viewModel.battleLog[0].teams[0].member[2].starPlayer, true)
//            XCTAssertEqual(self.viewModel.battleLog[0].teams[0].member[0].starPlayer, false)
//            expectation.fulfill()
//        }
//    }
    func testStarPlayer() {
        let expectation = XCTestExpectation(description: "Check starPlayer values")
        
        viewModel.fetchBattleLog()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard self.viewModel.battleLog.count > 0,
                  self.viewModel.battleLog[0].teams.count > 0,
                  self.viewModel.battleLog[0].teams[0].member.count >= 3 else {
                XCTFail("Test data structure is invalid.")
                expectation.fulfill()
                return
            }
            
            XCTAssertTrue(self.viewModel.battleLog[0].teams[0].member[2].starPlayer,
                          "Expected last member to be star player")
            XCTAssertFalse(self.viewModel.battleLog[0].teams[0].member[0].starPlayer,
                           "Expected first member not to be star player")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

    
    
}

