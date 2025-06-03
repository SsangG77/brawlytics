//
//  BrawlerJudgeTests.swift
//  BrawlyticsTests
//
//  Created by 차상진 on 5/28/25.
//

import XCTest
@testable import Brawlytics

final class BrawlerJudgeTests: XCTestCase {
    
    var judge: BrawlerJudge!
    
    override func setUpWithError() throws {
        judge = BrawlerJudgeImpl()
    }
    
    override func tearDownWithError() throws {
        judge = nil
    }
    
    /// 장비(Gear) 존재 여부 판단 테스트
    /// - 장비가 존재하는 경우 true 반환
    /// - 장비가 존재하지 않는 경우 false 반환
    func testJudgeGear() throws {
        let gears = [
            Gear(id: 1, name: "SPEED", level: 1),
            Gear(id: 2, name: "HEALTH", level: 1)
        ]
        
        XCTAssertTrue(judge.judgeGear(gears: gears, gear: "SPEED"))
        XCTAssertTrue(judge.judgeGear(gears: gears, gear: "HEALTH"))
        XCTAssertFalse(judge.judgeGear(gears: gears, gear: "DAMAGE"))
    }
    
    /// 가젯(Gadget) 존재 여부 판단 테스트
    /// - 가젯이 존재하는 경우 true 반환
    /// - 가젯이 존재하지 않는 경우 false 반환
    func testJudgeGadget() throws {
        let gadgets = [
            Gadget(id: 1, name: "T-BONE INJECTOR"),
            Gadget(id: 2, name: "STOMPER")
        ]
        
        XCTAssertTrue(judge.judgeGadget(gadgets: gadgets, gadget: "T-BONE INJECTOR"))
        XCTAssertTrue(judge.judgeGadget(gadgets: gadgets, gadget: "STOMPER"))
        XCTAssertFalse(judge.judgeGadget(gadgets: gadgets, gadget: "UNKNOWN"))
    }
    
    /// 스타파워(StarPower) 존재 여부 판단 테스트
    /// - 스타파워가 존재하는 경우 true 반환
    /// - 스타파워가 존재하지 않는 경우 false 반환
    func testJudgeStarPower() throws {
        let starPowers = [
            StarPower(id: 1, name: "BERSERKER"),
            StarPower(id: 2, name: "TOUGH GUY")
        ]
        
        XCTAssertTrue(judge.judgeStarPower(starPowers: starPowers, starPower: "BERSERKER"))
        XCTAssertTrue(judge.judgeStarPower(starPowers: starPowers, starPower: "TOUGH GUY"))
        XCTAssertFalse(judge.judgeStarPower(starPowers: starPowers, starPower: "UNKNOWN"))
    }
    
    /// 빈 배열에 대한 판단 테스트
    /// - 장비/가젯/스타파워 배열이 비어있는 경우 모두 false 반환
    func testJudgeEmptyArrays() throws {
        XCTAssertFalse(judge.judgeGear(gears: [], gear: "SPEED"))
        XCTAssertFalse(judge.judgeGadget(gadgets: [], gadget: "T-BONE INJECTOR"))
        XCTAssertFalse(judge.judgeStarPower(starPowers: [], starPower: "BERSERKER"))
    }
    
    /// 대소문자 구분 테스트
    /// - 장비/가젯/스타파워 이름의 대소문자가 다른 경우 false 반환
    func testJudgeCaseSensitivity() throws {
        let gears = [Gear(id: 1, name: "SPEED", level: 1)]
        let gadgets = [Gadget(id: 1, name: "T-BONE INJECTOR")]
        let starPowers = [StarPower(id: 1, name: "BERSERKER")]
        
        XCTAssertFalse(judge.judgeGear(gears: gears, gear: "speed"))
        XCTAssertFalse(judge.judgeGadget(gadgets: gadgets, gadget: "t-bone injector"))
        XCTAssertFalse(judge.judgeStarPower(starPowers: starPowers, starPower: "berserker"))
    }
    
    /// 여러 아이템이 있는 경우의 판단 테스트
    /// - 모든 아이템이 존재하는 경우 true 반환
    /// - 일부 아이템만 존재하는 경우 true 반환
    /// - 존재하지 않는 아이템의 경우 false 반환
    func testJudgeMultipleItems() throws {
        let gears = [
            Gear(id: 1, name: "SPEED", level: 1),
            Gear(id: 2, name: "HEALTH", level: 1),
            Gear(id: 3, name: "DAMAGE", level: 1)
        ]
        
        let gadgets = [
            Gadget(id: 1, name: "T-BONE INJECTOR"),
            Gadget(id: 2, name: "STOMPER"),
            Gadget(id: 3, name: "GROW LIGHT")
        ]
        
        let starPowers = [
            StarPower(id: 1, name: "BERSERKER"),
            StarPower(id: 2, name: "TOUGH GUY"),
            StarPower(id: 3, name: "EL FUEGO")
        ]
        
        // 모든 아이템이 존재하는 경우
        XCTAssertTrue(judge.judgeGear(gears: gears, gear: "SPEED"))
        XCTAssertTrue(judge.judgeGadget(gadgets: gadgets, gadget: "T-BONE INJECTOR"))
        XCTAssertTrue(judge.judgeStarPower(starPowers: starPowers, starPower: "BERSERKER"))
        
        // 일부 아이템만 존재하는 경우
        XCTAssertTrue(judge.judgeGear(gears: gears, gear: "HEALTH"))
        XCTAssertTrue(judge.judgeGadget(gadgets: gadgets, gadget: "STOMPER"))
        XCTAssertTrue(judge.judgeStarPower(starPowers: starPowers, starPower: "TOUGH GUY"))
        
        // 존재하지 않는 아이템
        XCTAssertFalse(judge.judgeGear(gears: gears, gear: "UNKNOWN"))
        XCTAssertFalse(judge.judgeGadget(gadgets: gadgets, gadget: "UNKNOWN"))
        XCTAssertFalse(judge.judgeStarPower(starPowers: starPowers, starPower: "UNKNOWN"))
    }
} 