//
//  BrawlersUseCaseTests.swift
//  BrawlyticsTests
//
//  Created by 차상진 on 5/28/25.
//

import XCTest
@testable import Brawlytics

final class BrawlersUseCaseTests: XCTestCase {
    
    var useCase: BrawlersUseCase!
    var mockRepository: MockBrawlersRepository!
    
    override func setUpWithError() throws {
        mockRepository = MockBrawlersRepository()
        useCase = BrawlersUseCaseImpl(repository: mockRepository)
    }
    
    override func tearDownWithError() throws {
        useCase = nil
        mockRepository = nil
    }
    
    func testCalculatePP() throws {
        let brawler = Brawler(
            id: 1,
            name: "BULL",
            power: 10,
            rank: 20,
            trophies: 500,
            highestTrophies: 600,
            gears: [Gear(id: 1, name: "SPEED", level: 1)],
            starPowers: [StarPower(id: 1, name: "BERSERKER")],
            gadgets: [Gadget(id: 1, name: "T-BONE INJECTOR")]
        )
        
        let standard = BrawlerStandard(
            name: "BULL",
            first_gadget: "T-BONE INJECTOR",
            second_gadget: "STOMPER",
            first_starPower: "BERSERKER",
            second_starPower: "TOUGH GUY",
            hypercharge: "JAWS OF STEEL",
            rarity: .rare,
            role: .tanker,
            epicGear: .superCharge,
            mythicGear: .none
        )
        
        let pp = useCase.calculatePP(brawler: brawler, brawlerStandard: standard)
        XCTAssertGreaterThan(pp, 0)
    }
    
    func testCalculateCredit() throws {
        let brawler = Brawler(
            id: 1,
            name: "BULL",
            power: 10,
            rank: 20,
            trophies: 500,
            highestTrophies: 600,
            gears: [Gear(id: 1, name: "SPEED", level: 1)],
            starPowers: [StarPower(id: 1, name: "BERSERKER")],
            gadgets: [Gadget(id: 1, name: "T-BONE INJECTOR")]
        )
        
        let standard = BrawlerStandard(
            name: "BULL",
            first_gadget: "T-BONE INJECTOR",
            second_gadget: "STOMPER",
            first_starPower: "BERSERKER",
            second_starPower: "TOUGH GUY",
            hypercharge: "JAWS OF STEEL",
            rarity: .rare,
            role: .tanker,
            epicGear: .superCharge,
            mythicGear: .none
        )
        
        let credit = useCase.calculateCredit(brawler: brawler, brawlerStandard: standard)
        XCTAssertGreaterThan(credit, 0)
    }
    
    func testCalculateCoin() throws {
        let brawler = Brawler(
            id: 1,
            name: "BULL",
            power: 10,
            rank: 20,
            trophies: 500,
            highestTrophies: 600,
            gears: [Gear(id: 1, name: "SPEED", level: 1)],
            starPowers: [StarPower(id: 1, name: "BERSERKER")],
            gadgets: [Gadget(id: 1, name: "T-BONE INJECTOR")]
        )
        
        let standard = BrawlerStandard(
            name: "BULL",
            first_gadget: "T-BONE INJECTOR",
            second_gadget: "STOMPER",
            first_starPower: "BERSERKER",
            second_starPower: "TOUGH GUY",
            hypercharge: "JAWS OF STEEL",
            rarity: .rare,
            role: .tanker,
            epicGear: .superCharge,
            mythicGear: .none
        )
        
        let coin = useCase.calculateCoin(brawler: brawler, brawlerStandard: standard)
        XCTAssertGreaterThan(coin, 0)
    }
    
    func testCalculateWithNilBrawler() throws {
        let standard = BrawlerStandard(
            name: "BULL",
            first_gadget: "T-BONE INJECTOR",
            second_gadget: "STOMPER",
            first_starPower: "BERSERKER",
            second_starPower: "TOUGH GUY",
            hypercharge: "JAWS OF STEEL",
            rarity: .rare,
            role: .tanker,
            epicGear: .superCharge,
            mythicGear: .none
        )
        
        let pp = useCase.calculatePP(brawler: nil, brawlerStandard: standard)
        let credit = useCase.calculateCredit(brawler: nil, brawlerStandard: standard)
        let coin = useCase.calculateCoin(brawler: nil, brawlerStandard: standard)
        
        XCTAssertEqual(pp, 0)
        XCTAssertEqual(credit, 0)
        XCTAssertEqual(coin, 0)
    }
} 